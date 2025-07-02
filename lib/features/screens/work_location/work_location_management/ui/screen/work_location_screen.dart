import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_body.dart';

class WorkLocationScreen extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return WorkLocationBody(
      selectedIndex: selectedIndex
    );
  }
}
