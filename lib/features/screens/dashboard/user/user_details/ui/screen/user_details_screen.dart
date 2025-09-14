import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/user_details_body.dart';

class UserDetailsScreen extends StatelessWidget {
  final int roleId;
  final int id;
  const UserDetailsScreen({super.key, required this.id, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return UserDetailsBody(
      id: id,
      roleId: roleId,
    );
  }
}
