import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/widgets/verify_account_body.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const VerifyAccountScreenBody(),
    );
  }
}
