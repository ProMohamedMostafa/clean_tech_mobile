import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_area_details/ui/widgets/view_organization_body.dart';

class AreaDetailsScreen extends StatelessWidget {
  final int id;
  const AreaDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AreaDetailsScreenBody(
      id: id,
    ));
  }
}
