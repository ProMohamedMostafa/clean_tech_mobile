import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_material/ui/widgets/materials_details_body.dart';

class MaterialDetailsScreen extends StatelessWidget {
  final int id;
  const MaterialDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialDetailsBody(id: id),
    );
  }
}
