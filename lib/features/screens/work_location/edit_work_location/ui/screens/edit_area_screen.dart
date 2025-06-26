import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/ui/widgets/edit_area_body.dart';

class EditAreaScreen extends StatelessWidget {
  final int id;
  const EditAreaScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditAreaBody(id: id);
  }
}
