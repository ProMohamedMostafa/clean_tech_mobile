import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/delete_work_location_list_item.dart';

class DeleteWorkLocationList extends StatelessWidget {
  final int selectedIndex;
  const DeleteWorkLocationList({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationCubit>();
    final deletedListData = selectedIndex == 0
        ? cubit.deletedAreaList?.data!
        : selectedIndex == 1
            ? cubit.deletedCityList?.data!
            : selectedIndex == 2
                ? cubit.deletedOrganizationList?.data!
                : selectedIndex == 3
                    ? cubit.deletedBuildingList?.data!
                    : selectedIndex == 4
                        ? cubit.deletedFloorList?.data!
                        : selectedIndex == 5
                            ? cubit.deletedSectionList?.data!
                            : cubit.deletedPointList?.data!;

    if (deletedListData == null || deletedListData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: selectedIndex == 0 ? cubit.scrollController : null,
        shrinkWrap: true,
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
              DeleteWorkLocationListItem(
                  selectedIndex: selectedIndex, index: index),
            ],
          );
        },
      );
    }
  }
}
