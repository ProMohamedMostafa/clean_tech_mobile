import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/task_details_body.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int id;
  const TaskDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return TaskDetailsBody(id: id);
  }
}
