import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/item_list_build.dart';

Widget userDetailsBuild(BuildContext context, int selectedIndex) {
  final cubit = context.read<UserManagementCubit>();
  final usersData = selectedIndex == 0
      ? cubit.usersModel?.data?.users
      : cubit.deletedListModel?.data;

  if (usersData == null || usersData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
      controller: selectedIndex == 0 ? cubit.scrollController : null,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: usersData.length,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[300],
          height: 0.1,
        );
      },
      itemBuilder: (context, index) {
        return Column(
          children: [
            listItemBuild(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
