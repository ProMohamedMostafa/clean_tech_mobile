import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/set_password_body.dart';

class SetPasswordScreen extends StatelessWidget {
  final String email;
  final int code;
  const SetPasswordScreen({super.key, required this.email, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SetPasswordbody(email: email, code: code),
    );
  }
}
