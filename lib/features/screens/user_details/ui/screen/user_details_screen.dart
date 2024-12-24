import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/user_details/ui/widgets/user_details_body.dart';

class UserDetailsScreen extends StatelessWidget {
  final int id;
  const UserDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UserDetailsBody(id: id,));
  }
}