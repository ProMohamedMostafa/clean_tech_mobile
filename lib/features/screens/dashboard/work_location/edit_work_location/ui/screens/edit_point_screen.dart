import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/widgets/edit_point_body.dart';

class EditPointScreen extends StatelessWidget {
  final int id;
  const EditPointScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditPointBody(id: id);
  }
}
