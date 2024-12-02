import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/layout/adaptive_screens/mobile_view.dart';
import 'package:smart_cleaning_application/features/layout/adaptive_screens/tablet_view.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return const MobileView();
      } else {
        return const TabletView();
      }
    });
  }
}
