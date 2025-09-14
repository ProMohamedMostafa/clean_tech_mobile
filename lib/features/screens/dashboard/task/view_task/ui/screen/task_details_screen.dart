import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/ui/widget/task_details_body.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int id;
  final int? selectedIndex;
  const TaskDetailsScreen(
      {super.key, required this.id, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return TaskDetailsBody(
      id: id,
      selectedIndex: selectedIndex ?? 0,
    );
  }
}
