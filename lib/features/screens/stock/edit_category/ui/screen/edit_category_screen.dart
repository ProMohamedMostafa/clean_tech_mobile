import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/ui/widgets/edit_category_body.dart';

class EditCategoryScreen extends StatelessWidget {
  final int id;
  const EditCategoryScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditCategoryBody(id: id);
  }
}
