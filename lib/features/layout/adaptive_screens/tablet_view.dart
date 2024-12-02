import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';

class TabletView extends StatelessWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return token!.isEmpty
        ? const Center(child: Text("Tablet"))
        : const HomeScreen();
  }
}
