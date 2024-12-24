import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/ui/widgets/edit_user_body.dart';

class EditUserScreen extends StatelessWidget {
  final int id;
  const EditUserScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditUserBody(id: id,));
  }
}