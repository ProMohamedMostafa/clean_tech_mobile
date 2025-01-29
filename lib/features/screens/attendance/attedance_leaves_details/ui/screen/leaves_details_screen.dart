import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attedance_leaves_details/ui/widgets/leaves_details_body.dart';

class LeavesDetailsScreen extends StatelessWidget {
  final int id ;
  const LeavesDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LeavesDetailsBody(id: id),);
  }
}