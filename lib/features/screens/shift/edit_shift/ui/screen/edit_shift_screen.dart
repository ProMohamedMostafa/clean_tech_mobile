import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/ui/widget/edit_shift_body.dart';

class EditShiftScreen extends StatelessWidget {
  final int id;
  const EditShiftScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditShiftBody(id: id));
  }
}
