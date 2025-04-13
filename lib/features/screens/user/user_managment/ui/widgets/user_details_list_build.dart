import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/item_list_build.dart';

Widget userDetailsBuild(BuildContext context, int selectedIndex) {
  final usersData = selectedIndex == 0
      ? context.read<UserManagementCubit>().usersModel?.data!.users
      : context.read<UserManagementCubit>().deletedListModel?.data;

  if (usersData == null || usersData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.builder(
      controller: selectedIndex == 0
          ? context.read<UserManagementCubit>().scrollController
          : null,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: usersData.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
              height: 0.1,
            ),
          ],
        );
      },
    );
  }
}
