import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/edit_devices/ui/widgets/edit_devices_body.dart';

class EditDevicesScreen extends StatelessWidget {
  final int id;
  const EditDevicesScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditDevicesBody(id:id);
  }
}