import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';

class CustomFilterCategoryDialog {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      buildHeader(context),

                      Text(
                        'Unit',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = [
                            'Ml',
                            'L',
                            'Kg',
                            'G',
                            'M',
                            'Cm',
                            'Pieces'
                          ];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            context
                                .read<CategoryManagementCubit>()
                                .unitIdController
                                .text = selectedIndex.toString();
                          }
                        },
                        hint: 'Select',
                        items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
                        controller: context
                            .read<CategoryManagementCubit>()
                            .unitController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context
                                  .read<CategoryManagementCubit>()
                                  .getCategoryList();
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
