import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/logic/feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class PopUpFeedbackAuditDialog {
  static Future<String?> show(
      {required BuildContext context,
      required int id,
      required int selectIndex}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        final cubit = context.read<FeedbackAuditCubit>();
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
                  onTap: () async {
                    final result = await context.pushReplacementNamed(
                      Routes.editFeedbackAuditScreen,
                      arguments: {
                        'id': id,
                        'selectIndex': selectIndex,
                      },
                    );

                    if (result == true) {
                      await cubit.refresh();
                    }
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
                              body: S.of(context).taskbody,
                              onPressed: () {
                                cubit.deleteFeedbackAudit(id);
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
