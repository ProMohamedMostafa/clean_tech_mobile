import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/user_managment_body.dart';

class userManagmentScreen extends StatelessWidget {
  const userManagmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserManagmentBody(),
    );
  }
}