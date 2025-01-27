import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/ui/widgets/edit_point_body.dart';

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
