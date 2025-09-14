import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/assign_question/ui/widget/assign_question_body.dart';

class AssignQuestionWithFeedbackAuditScreen extends StatelessWidget {
  final int sectionId;
  final int id;

  const AssignQuestionWithFeedbackAuditScreen({
    super.key,
    required this.id,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    return AssignQuestionWithFeedbackAuditBody(
      sectionId: sectionId,
      id: id,
    );
  }
}
