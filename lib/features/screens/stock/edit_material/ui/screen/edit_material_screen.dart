import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/ui/widgets/edit_material_body.dart';

class EditMaterialScreen extends StatelessWidget {
  final int id;
  const EditMaterialScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditMaterialBody(
        id: id,
      ),
    );
  }
}
