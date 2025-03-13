import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/ui/widgets/edit_section_body.dart';

class EditSectionScreen extends StatelessWidget {
  final int id;
  const EditSectionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditSectionBody(id: id),
    );
  }
}
