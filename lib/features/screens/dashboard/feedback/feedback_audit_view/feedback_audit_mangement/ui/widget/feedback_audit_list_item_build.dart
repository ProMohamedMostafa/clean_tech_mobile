import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/logic/feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/ui/widget/pop_up_feedback_audit_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAuditListItemBuild extends StatelessWidget {
  final int index;
  const FeedbackAuditListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedbackAuditCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(
          Routes.feedbackAuditDetailsScreen,
          arguments: {
            'id': cubit.selectedIndex == 0
                ? cubit.allFeedbackModel!.data!.data![index].id!
                : cubit.allAuditModel!.data!.data![index].id!,
            'selectIndex': cubit.selectedIndex,
          },
        );
        if (result == true) {
          cubit.refresh();
        }
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.allFeedbackModel!.data!.data![index].name!
                        : cubit.allAuditModel!.data!.data![index].name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      PopUpFeedbackAuditDialog.show(
                        context: context,
                        id: cubit.selectedIndex == 0
                            ? cubit.allFeedbackModel!.data!.data![index].id!
                            : cubit.allAuditModel!.data!.data![index].id!,
                        selectIndex: cubit.selectedIndex,
                      );
                    },
                    icon: Icon(Icons.more_horiz_rounded, size: 22.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: S.of(context).section,
                              style: TextStyles.font11GreyMedium),
                          TextSpan(
                              text:
                                  ' ${cubit.selectedIndex == 0 ? cubit.allFeedbackModel!.data!.data![index].sectionName! : cubit.allAuditModel!.data!.data![index].sectionName!}',
                              style: TextStyles.font12PrimSemi),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: S.of(context).question_label,
                              style: TextStyles.font11GreyMedium),
                          TextSpan(
                              text:
                                  ' ${cubit.selectedIndex == 0 ? cubit.allFeedbackModel!.data!.data![index].questionCount : cubit.allAuditModel!.data!.data![index].questionCount ?? 0}',
                              style: TextStyles.font12PrimSemi),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(3)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
