import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/ui/widgets/edit_building_body.dart';

class EditBuildingScreen extends StatelessWidget {
  final int id;
  const EditBuildingScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditBuildingBody(id: id),
    );
  }
}
