import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/logic/task_details_cubit.dart';

class CustomCurrentReadDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        double? currentReading;

        return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currently reading',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        onlyRead: false,
                        hint: "Write Currently reading",
                        controller: context
                            .read<TaskDetailsCubit>()
                            .currentReadingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Currently reading is Required";
                          } else if (value.length > 30) {
                            return 'Currently reading too long';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          currentReading = double.parse(value);
                        },
                      ),
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Confirm',
                            onPressed: () {
                              context.read<TaskDetailsCubit>().changeTaskStatus(
                                  id, 2,
                                  reading: currentReading);
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
