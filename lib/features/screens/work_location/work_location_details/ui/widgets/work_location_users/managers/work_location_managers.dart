import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_users/managers/build_managers_item_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationManagers extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationManagers({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final usersData = selectedIndex == 0
        ? cubit.areaUsersDetailsModel!.data!.users!
            .where((user) => user.role == 'Manager')
        : selectedIndex == 1
            ? cubit.cityUsersDetailsModel!.data!.users!
                .where((user) => user.role == 'Manager')
            : selectedIndex == 2
                ? cubit.organizationUsersShiftDetailsModel!.data!.users!
                    .where((user) => user.role == 'Manager')
                : selectedIndex == 3
                    ? cubit.buildingUsersShiftDetailsModel!.data!.users!
                        .where((user) => user.role == 'Manager')
                    : selectedIndex == 4
                        ? cubit.floorUsersShiftDetailsModel!.data!.users!
                            .where((user) => user.role == 'Manager')
                        : selectedIndex == 5
                            ? cubit.sectionUsersShiftDetailsModel!.data!.users!
                                .where((user) => user.role == 'Manager')
                            : selectedIndex == 6
                                ? cubit.pointUsersDetailsModel!.data!.users!
                                    .where((user) => user.role == 'Manager')
                                : null;

    if (usersData == null || usersData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
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
          return BuildManagersItemList(
            selectedIndex: selectedIndex,
            index: index,
          );
        },
      );
    }
  }
}
