import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/ui/widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  final int id;
  const EditProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditProfileBody(id: id,));
  }
}