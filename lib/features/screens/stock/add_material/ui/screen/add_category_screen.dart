import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/ui/widgets/add_category_body.dart';

class AddMaterialScreen extends StatelessWidget {
  const AddMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddMaterialBody(),
    );
  }
}
