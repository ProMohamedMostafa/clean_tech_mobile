import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_edit/ui/widget/sensor_assign_body.dart';

class SensorEditScreen extends StatelessWidget {
  final int id;
  const SensorEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SensorEditBody(id: id);
  }
}
