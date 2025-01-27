import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/ui/widgets/delete_organization_body.dart';

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
