import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_building_details/ui/widgets/view_organization_body.dart';

class BuildingDetailsScreen extends StatelessWidget {
  final int id;
  const BuildingDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BuildingDetailsScreenBody(
      id: id,
    ));
  }
}
