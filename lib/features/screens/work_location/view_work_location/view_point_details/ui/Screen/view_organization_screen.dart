import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/ui/widgets/view_point_body.dart';

class PointDetailsScreen extends StatelessWidget {
  final int id;
  const PointDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PointDetailsScreenBody(
      id: id,
    ));
  }
}
