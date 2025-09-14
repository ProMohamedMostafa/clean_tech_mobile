import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attedance_leaves_details/ui/widgets/leaves_details_body.dart';

class LeavesDetailsScreen extends StatelessWidget {
  final bool isProfile;
  final int id;
  const LeavesDetailsScreen(
      {super.key, required this.id, required this.isProfile});

  @override
  Widget build(BuildContext context) {
    return LeavesDetailsBody(
      id: id,
      isProfile: isProfile,
    );
  }
}
