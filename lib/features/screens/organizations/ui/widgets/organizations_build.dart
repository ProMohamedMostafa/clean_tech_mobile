import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organizations_list_item_build.dart';

Widget organizationDetailsBuild(BuildContext context, int selectedIndex) {
  // final usersData = selectedIndex == 0
  //     ? context.read<OrganizationsCubit>().usersModel!.data!
  //     : context.read<OrganizationsCubit>().deletedListModel!.data!;

  // if (usersData.isEmpty) {
  //   return Center(
  //     child: Text(
  //       "There's no data",
  //       style: TextStyles.font13Blackmedium,
  //     ),
  //   );
  // } else 
  // {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      // itemCount: usersData.length,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            organizationsListItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
            ),
          ],
        );
      },
    );
  }
// }
