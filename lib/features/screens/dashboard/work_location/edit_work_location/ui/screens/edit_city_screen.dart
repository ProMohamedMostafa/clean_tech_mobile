import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/widgets/edit_city_body.dart';

class EditCityScreen extends StatelessWidget {
  final int id;
  const EditCityScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return EditCityBody(id: id);
  }
}
