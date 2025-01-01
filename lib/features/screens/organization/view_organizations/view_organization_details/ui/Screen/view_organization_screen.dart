import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_organization_details/ui/widgets/view_organization_body.dart';

class OrganizationDetailsScreen extends StatelessWidget {
  final int id;
  const OrganizationDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrganizationDetailsScreenBody(
      id: id,
    ));
  }
}
