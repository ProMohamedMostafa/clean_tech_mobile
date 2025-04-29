import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/list_item_build.dart';

Widget activityListDetailsBuild(BuildContext context, int selectedIndex) {
  final cubit = context.read<ActivityCubit>();
  final activitiesData = selectedIndex == 0
      ? cubit.myActivities?.data?.activities ?? []
      : cubit.teamActivities?.data?.activities ?? [];

  if (activitiesData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  }

  return ListView.separated(
    controller: cubit.activitiesScrollController,
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: activitiesData.length,
    separatorBuilder: (context, index) => verticalSpace(10),
    itemBuilder: (context, index) =>
        listItemBuild(context, selectedIndex, index),
  );
}
