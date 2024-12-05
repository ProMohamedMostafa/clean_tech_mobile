import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/done_screen/ui/widgets/done_screen_body.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DoneScreenBody(),
    );
  }
}