import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/ui/widgets/edit_area_body.dart';

class EditAreaScreen extends StatelessWidget {
  final int id;
  const EditAreaScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditAreaBody(id: id),
    );
  }
}
