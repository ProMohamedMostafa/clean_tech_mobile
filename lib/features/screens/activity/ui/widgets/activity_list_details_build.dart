import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/list_item_build.dart';

Widget activityListDetailsBuild(BuildContext context, int selectedIndex) {
  final activitiesData = selectedIndex == 0
      ? context.read<ActivityCubit>().myActivities?.data.data
      : context.read<ActivityCubit>().teamActivities?.data.data;

  if (activitiesData == null || activitiesData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
      controller: selectedIndex == 0
          ? context.read<ActivityCubit>().myActivitiesScrollController
          : context.read<ActivityCubit>().teamActivitiesScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: activitiesData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listItemBuild(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
