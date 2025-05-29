import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/build_user_item_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsList extends StatelessWidget {
  const UserDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserManagementCubit>();
    final usersData = cubit.selectedIndex == 0
        ? cubit.usersModel?.data?.users
        : cubit.deletedListModel?.data;

    if (usersData == null || usersData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.selectedIndex == 0 ? cubit.scrollController : null,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: usersData.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
            height: 0,
          );
        },
        itemBuilder: (context, index) {
          return BuildUserItemList(index: index);
        },
      );
    }
  }
}
