import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/material_managment_body.dart';

class MaterialManagmentScreen extends StatelessWidget {
  const MaterialManagmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialManagmentBody(),
    );
  }
}
