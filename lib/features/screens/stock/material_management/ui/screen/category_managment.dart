import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/material_managment_body.dart';

class MaterialManagmentScreen extends StatelessWidget {
  final int? id;

  const MaterialManagmentScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialManagmentBody(
        id: id,
      ),
    );
  }
}
