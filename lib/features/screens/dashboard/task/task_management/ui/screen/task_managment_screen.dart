import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/ui/widget/task_management_body.dart';

class TaskManagementScreen extends StatelessWidget {
  final int index;
  const TaskManagementScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return TaskManagementBody(index: index);
  }
}
