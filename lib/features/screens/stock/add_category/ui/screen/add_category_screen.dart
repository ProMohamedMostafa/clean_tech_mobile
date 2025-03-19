import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/ui/widgets/add_category_body.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddCategoryBody(),
    );
  }
}
