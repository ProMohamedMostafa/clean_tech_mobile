import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/ui/widgets/delete_organization_body.dart';

class DeleteOrganizationScreen extends StatelessWidget {
  final int selectedIndex;
  const DeleteOrganizationScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeleteOrganizationBody(selectedIndex: selectedIndex),
    );
  }
}
