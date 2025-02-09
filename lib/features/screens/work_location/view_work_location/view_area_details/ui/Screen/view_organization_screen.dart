import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_area_details/ui/widgets/view_area_body.dart';

class AreaDetailsScreen extends StatelessWidget {
  final int selectedIndex;
  final int id;
  const AreaDetailsScreen(
      {super.key, required this.id, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AreaDetailsScreenBody(
      selectedIndex: selectedIndex,
      id: id,
    ));
  }
}
