import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/ui/widgets/shift_body.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShiftBody(),
    );
  }
}
