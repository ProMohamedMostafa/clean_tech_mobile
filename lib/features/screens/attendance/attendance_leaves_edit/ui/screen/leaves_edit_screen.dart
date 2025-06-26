import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/ui/widgets/leaves_edit_body.dart';

class LeavesEditScreen extends StatelessWidget {
  final int id;
  const LeavesEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return LeavesEditBody(id:id);
  }
}