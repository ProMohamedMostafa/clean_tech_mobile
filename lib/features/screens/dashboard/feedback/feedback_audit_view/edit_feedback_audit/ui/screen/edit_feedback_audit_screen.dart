import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/ui/widget/edit_feedback_audit_body.dart';

class EditFeedbackAuditScreen extends StatelessWidget {
  final int selectIndex;
  final int id;
  const EditFeedbackAuditScreen(
      {super.key, required this.id, required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    return EditFeedbackAuditBody(
      selectIndex: selectIndex,
      id: id,
    );
  }
}
