import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/logic/feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/ui/widget/feedback_audit_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAuditListBuild extends StatelessWidget {
  const FeedbackAuditListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedbackAuditCubit>();

    final data = cubit.selectedIndex == 0
        ? cubit.allFeedbackModel?.data?.data
        : cubit.allAuditModel?.data?.data;

    if (data == null || data.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.selectedIndex == 0
          ? cubit.feedbackScrollController
          : cubit.auditScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) => FeedbackAuditListItemBuild(index: index),
    );
  }
}
