import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/ui/widget/assign_body.dart';

class AssignScreen extends StatelessWidget {
  final int index;
  const AssignScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AssignBody(index: index);
  }
}
