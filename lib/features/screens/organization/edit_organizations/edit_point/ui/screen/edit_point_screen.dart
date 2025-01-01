import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/ui/widgets/edit_point_body.dart';

class EditPointScreen extends StatelessWidget {
  final int id;
  const EditPointScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditPointBody(id: id),
    );
  }
}
