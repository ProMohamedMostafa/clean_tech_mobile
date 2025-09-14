import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_answers/ui/widgets/device_answers_body.dart';

class DeviceAnswersScreen extends StatelessWidget {
  final int id;
  const DeviceAnswersScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return DeviceAnswersBody(id:id);
  }
}