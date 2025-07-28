import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/ui/widgets/list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ActivityListDetailsBuild extends StatelessWidget {
  const ActivityListDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActivityCubit>();

    if (cubit.selectedIndex == 0
        ? cubit.myActivities == null
        : cubit.teamActivities == null) {
      return Center(child: Loading());
    }

    final activitiesData = cubit.selectedIndex == 0
        ? cubit.myActivities?.data?.activities ?? []
        : cubit.teamActivities?.data?.activities ?? [];

    if (activitiesData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.activitiesScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: activitiesData.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) => ActivityListItemBuild(index: index),
    );
  }
}
