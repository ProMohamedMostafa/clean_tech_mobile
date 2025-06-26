import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/ui/widgets/edit_building_body.dart';

class EditBuildingScreen extends StatelessWidget {
  final int id;
  const EditBuildingScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditBuildingBody(id: id);
  }
}
