import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_managment_body.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserManagmentScreen extends StatelessWidget {
  const UserManagmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(S.of(context).userManagement),
      ),
      floatingActionButton: role == 'Admin'
          ? floatingActionButton(
              icon: Icons.person_add,
              onPressed: () {
                context.pushNamed(Routes.addUserScreen);
              },
            )
          : SizedBox.shrink(),
      body: UserManagmentBody(),
    );
  }
}
