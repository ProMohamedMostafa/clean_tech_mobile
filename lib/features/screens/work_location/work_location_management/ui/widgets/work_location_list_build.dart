import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_list_item_build.dart';

class WorkLocationListBuild extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationListBuild({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationCubit>();
    final workLocationData = selectedIndex == 0
        ? cubit.areaModel?.data?.data
        : selectedIndex == 1
            ? cubit.cityModel?.data?.data
            : selectedIndex == 2
                ? cubit.organizationModel?.data?.data
                : selectedIndex == 3
                    ? cubit.buildingModel?.data?.data
                    : selectedIndex == 4
                        ? cubit.floorModel?.data?.data
                        : selectedIndex == 5
                            ? cubit.sectionModel?.data?.data
                            : cubit.pointModel?.data?.data;

    if (workLocationData == null || workLocationData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: selectedIndex == 8 ? null : cubit.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: workLocationData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              WorkLocationListItemBuild(
                  selectedIndex: selectedIndex, index: index),
            ],
          );
        },
      );
    }
  }
}
