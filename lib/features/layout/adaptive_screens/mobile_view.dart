import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/screens/login/ui/screen/login_screen.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return token!.isEmpty
        ? const LoginScreen()
        : const Center(child: Text("Mobile"));
  }
}
