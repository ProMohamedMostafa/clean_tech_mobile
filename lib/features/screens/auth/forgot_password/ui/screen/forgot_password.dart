import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/ui/widgets/forgot_screen_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ForgotScreenBody(),
    );
  }
}
