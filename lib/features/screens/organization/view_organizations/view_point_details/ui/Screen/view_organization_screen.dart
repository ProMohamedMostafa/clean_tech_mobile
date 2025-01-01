import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_point_details/ui/widgets/view_organization_body.dart';

class PointDetailsScreen extends StatelessWidget {
  final int id;
  const PointDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PointDetailsScreenBody(
      id: id,
    ));
  }
}
