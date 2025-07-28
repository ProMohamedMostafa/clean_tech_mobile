import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/widgets/edit_floor_body.dart';

class EditFloorScreen extends StatelessWidget {
  final int id;
  const EditFloorScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditFloorBody(id: id);
  }
}
