import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/attendance_leaves_body.dart';

class AttendanceLeavesScreen extends StatelessWidget {
  const AttendanceLeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AttendanceLeavesBody(),);
  }
}