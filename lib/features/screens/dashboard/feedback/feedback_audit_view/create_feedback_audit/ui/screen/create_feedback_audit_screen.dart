import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/create_feedback_audit/ui/widget/create_feedback_audit_body.dart';

class AddFeedbackAuditScreen extends StatelessWidget {
  final int selectindex;
  const AddFeedbackAuditScreen({super.key, required this.selectindex});

  @override
  Widget build(BuildContext context) {
    return AddFeedbackAuditBody(selectIndex: selectindex,);
  }
}
