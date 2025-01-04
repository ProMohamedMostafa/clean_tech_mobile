import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/shift_details_body.dart';

class ShiftDetailsScreen extends StatelessWidget {
  final int id;
  const ShiftDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShiftDetailsBody(
        id: id,
      ),
    );
  }
}
