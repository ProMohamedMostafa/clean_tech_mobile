import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class PopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.pushReplacementNamed(Routes.editMaterialScreen,
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
                          S.of(context).editButton,
                          style: TextStyles.font18PrimBold,
                        ),
                      )),
                ),
                verticalSpace(10),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return PopUpMessage(
                              title: S.of(context).TitleDelete,
                              body: S.of(context).materialBody,
                              onPressed: () {
                                context
                                    .read<MaterialManagementCubit>()
                                    .deleteMaterial(id);
                                context.pop();
                              });
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
                          S.of(context).deleteButton,
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
