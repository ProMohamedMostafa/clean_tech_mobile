import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/ui/widget/feedback_audit_details_body.dart';

class FeedbackAuditDetailsScreen extends StatelessWidget {
  final int selectIndex;
  final int id;
  const FeedbackAuditDetailsScreen(
      {super.key, required this.id, required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    return FeedbackAuditDetailsBody(
      id: id,
      selectIndex: selectIndex,
    );
  }
}
