import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/ui/widgets/view_floor_body.dart';

class FloorDetailsScreen extends StatelessWidget {
  final int id;
  const FloorDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FloorDetailsScreenBody(
      id: id,
    ));
  }
}
