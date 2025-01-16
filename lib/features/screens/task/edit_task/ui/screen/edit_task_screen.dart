import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/ui/widget/edit_task_body.dart';

class EditTaskScreen extends StatelessWidget {
  final int id;
  const EditTaskScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditTaskBody(id:id),);
  }
}