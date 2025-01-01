import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_floor_details/ui/widgets/view_organization_body.dart';

class FloorDetailsScreen extends StatelessWidget {
  final int id;
  const FloorDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FloorDetailsScreenBody(
      id: id,
    ));
  }
}
