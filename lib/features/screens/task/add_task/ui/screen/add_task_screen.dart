import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/ui/widget/add_task_body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddTaskBody(),);
  }
}