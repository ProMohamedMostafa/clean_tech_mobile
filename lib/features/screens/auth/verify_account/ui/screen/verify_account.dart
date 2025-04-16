import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/widgets/verify_account_body.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String email;
  const VerifyAccountScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  VerifyAccountScreenBody(email: email),
    );
  }
}
