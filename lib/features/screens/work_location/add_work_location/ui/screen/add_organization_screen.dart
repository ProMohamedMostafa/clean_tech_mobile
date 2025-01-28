import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/widgets/add_work_location_body.dart';

class AddOrganizationScreen extends StatelessWidget {
  const AddOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddWorkLocationBody(),
    );
  }
}