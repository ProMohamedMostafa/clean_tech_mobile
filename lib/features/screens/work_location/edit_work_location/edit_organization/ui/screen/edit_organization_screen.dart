import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/ui/widgets/edit_organization_body.dart';

class EditOrganizationScreen extends StatelessWidget {
  final int id;
  const EditOrganizationScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditOrganizationBody(id: id),
    );
  }
}
