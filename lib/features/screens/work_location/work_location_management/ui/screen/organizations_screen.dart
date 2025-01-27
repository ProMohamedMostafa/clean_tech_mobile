import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/organizations_body.dart';

class OrganizationsScreen extends StatelessWidget {
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrganizationsBody()
    );
  }
}