import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class UserManagmentBody extends StatelessWidget {
  const UserManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [Text("UserManagament")],
        ),
      )),
    );
  }
}
