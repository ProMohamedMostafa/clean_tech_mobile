import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return token!.isEmpty
        ? const LoginScreen()
        : const MainLayout();
  }
}
