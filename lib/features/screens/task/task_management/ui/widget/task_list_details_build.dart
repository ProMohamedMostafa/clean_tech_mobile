import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/list_item_build.dart';

Widget taskListDetailsBuild(BuildContext context, TaskManagementState state,
    TaskManagementCubit cubit) {
  if (state is GetAllTasksLoadingState || state is TaskDeleteListLoadingState) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      ),
    );
  }

  final itemCount = cubit.selectedIndex == 8
      ? cubit.deleteTaskListModel?.data?.length ?? 0
      : cubit.allTasksModel?.data?.data?.length ?? 0;

  if (itemCount == 0) {
    return Center(
      child: Text(
        'There\'s no data',
        style: TextStyles.font16GreyMedium,
      ),
    );
  }

  return Skeletonizer(
    enabled: cubit.allTasksModel == null,
    child: ListView.separated(
      controller: cubit.selectedIndex == 8 ? null : cubit.scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemCount: itemCount,
      itemBuilder: (context, index) => buildCardItem(context, index),
    ),
  );
}
