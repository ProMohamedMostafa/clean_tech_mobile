import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/widgets/save_organization_body.dart';

class AddOrganizationScreen extends StatelessWidget {
  const AddOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddOrganizationBody(),
    );
  }
}