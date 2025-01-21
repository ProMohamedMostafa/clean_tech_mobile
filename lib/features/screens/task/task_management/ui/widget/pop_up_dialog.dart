import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';

class PopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.pushReplacementNamed(Routes.editTaskScreen,
                        arguments: id);
                  },
                  child: Container(
                      height: 50.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.primaryColor)),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyles.font18PrimBold,
                        ),
                      )),
                ),
                verticalSpace(10),
                InkWell(
                  onTap: () {
                    showCustomDialog(
                        context, "Are you sure you want to delete this task",
                        () {
                      context.read<TaskManagementCubit>().taskDelete(id);
                      context.pop();
                      context.pop();
                    });
                  },
                  child: Container(
                      height: 50.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.red)),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyles.font18PrimBold
                              .copyWith(color: Colors.red),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
