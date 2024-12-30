import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/edit_organization/ui/widgets/edit_organization_body.dart';

class EditOrganizationScreen extends StatelessWidget {
  const EditOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditOrganizationBody(),
    );
  }
}