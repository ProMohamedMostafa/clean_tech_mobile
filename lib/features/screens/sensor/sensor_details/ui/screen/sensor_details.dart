import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_details/ui/widget/sensor_details_body.dart';

class SensorDetailsScreen extends StatelessWidget {
  final int id;
  const SensorDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SensorDetailsBody(id: id,);
  }
}
