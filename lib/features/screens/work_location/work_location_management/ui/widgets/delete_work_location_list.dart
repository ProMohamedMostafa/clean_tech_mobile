import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/delete_work_location_list_item.dart';

Widget deleteOrganizationListBuild(BuildContext context, int selectedIndex) {
  final deletedListData = selectedIndex == 0
      ? context.read<WorkLocationCubit>().deletedAreaList?.data!
      : selectedIndex == 1
          ? context.read<WorkLocationCubit>().deletedCityList?.data!
          : selectedIndex == 2
              ? context.read<WorkLocationCubit>().deletedOrganizationList?.data!
              : selectedIndex == 3
                  ? context.read<WorkLocationCubit>().deletedBuildingList?.data!
                  : selectedIndex == 4
                      ? context
                          .read<WorkLocationCubit>()
                          .deletedFloorList
                          ?.data!
                      : selectedIndex == 5
                          ? context
                              .read<WorkLocationCubit>()
                              .deletedSectionList
                              ?.data!
                          : context
                              .read<WorkLocationCubit>()
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: deletedListData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            deleteOrganizationsListItemBuild(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
