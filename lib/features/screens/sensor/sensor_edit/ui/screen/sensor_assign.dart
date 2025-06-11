import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_edit/ui/widget/sensor_assign_body.dart';

class SensorAssignScreen extends StatelessWidget {
  final int id;
  const SensorAssignScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SensorAssignBody(id: id);
  }
}
