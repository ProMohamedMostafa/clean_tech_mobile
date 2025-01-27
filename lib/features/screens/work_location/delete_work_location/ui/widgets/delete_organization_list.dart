import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/logic/delete_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/ui/widgets/delete_organization_list_item.dart';

Widget deleteOrganizationListBuild(BuildContext context, int selectedIndex) {
  final deletedListData = selectedIndex == 0
      ? context.read<DeleteOrganizationsCubit>().deletedAreaList?.data!
      : selectedIndex == 1
          ? context.read<DeleteOrganizationsCubit>().deletedCityList?.data!
          : selectedIndex == 2
              ? context
                  .read<DeleteOrganizationsCubit>()
                  .deletedOrganizationList
                  ?.data!
              : selectedIndex == 3
                  ? context
                      .read<DeleteOrganizationsCubit>()
                      .deletedBuildingList
                      ?.data!
                  : selectedIndex == 4
                      ? context
                          .read<DeleteOrganizationsCubit>()
                          .deletedFloorList
                          ?.data!
                      : context
                          .read<DeleteOrganizationsCubit>()
                          .deletedPointList
                          ?.data!;

  if (deletedListData == null || deletedListData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: deletedListData.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            deleteOrganizationsListItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
            ),
          ],
        );
      },
    );
  }
}
