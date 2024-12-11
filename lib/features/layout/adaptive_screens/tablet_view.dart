import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';

class TabletView extends StatelessWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return token!.isEmpty
        ? Center(child: Text("Tablet Screen"))
        : const LoginScreen();
  }
}
