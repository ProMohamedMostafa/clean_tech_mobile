import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/ui/widget/assign_question_body.dart';

class AssignQuestionPointScreen extends StatelessWidget {
  final int id;
final int sectionId;
  const AssignQuestionPointScreen({
    super.key,
    required this.id, required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    return AssignQuestionPointBody(
      id: id,
      sectionId: sectionId,
    );
  }
}
