import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_city_details/ui/widgets/view_organization_body.dart';

class CityDetailsScreen extends StatelessWidget {
  final int id;
  const CityDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CityDetailsScreenBody(
      id: id,
    ));
  }
}
