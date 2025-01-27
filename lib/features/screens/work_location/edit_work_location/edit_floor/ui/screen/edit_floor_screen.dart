import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/ui/widgets/edit_floor_body.dart';

class EditFloorScreen extends StatelessWidget {
  final int id;
  const EditFloorScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditFloorBody(id: id),
    );
  }
}
