import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_list_item_build.dart';

Widget workLocationDetailsBuild(BuildContext context, int selectedIndex) {
  final workLocationData = selectedIndex == 0
      ? context.read<WorkLocationCubit>().areaModel?.data?.data
      : selectedIndex == 1
          ? context.read<WorkLocationCubit>().cityModel?.data?.data
          : selectedIndex == 2
              ? context.read<WorkLocationCubit>().organizationModel?.data?.data
              : selectedIndex == 3
                  ? context.read<WorkLocationCubit>().buildingModel?.data?.data
                  : selectedIndex == 4
                      ? context.read<WorkLocationCubit>().floorModel?.data?.data
                      : selectedIndex == 5
                          ? context
                              .read<WorkLocationCubit>()
                              .sectionModel
                              ?.data
                              ?.data
                          : context
                              .read<WorkLocationCubit>()
                              .pointModel
                              ?.data
                              ?.data;

  if (workLocationData == null || workLocationData.isEmpty) {
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
      itemCount: workLocationData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            organizationsListItemBuild(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
