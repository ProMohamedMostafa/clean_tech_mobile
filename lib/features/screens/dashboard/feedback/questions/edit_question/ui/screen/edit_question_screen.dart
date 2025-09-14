import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/ui/widget/edit_question_body.dart';

class EditQuestionScreen extends StatelessWidget {
  final int id;
  const EditQuestionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditQuestionBody(id:id);
  }
}
