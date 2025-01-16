import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/list_item_build.dart';

Widget taskListDetailsBuild(
    BuildContext context, int selectedIndex, selectedDate) {
  final tasksData = selectedIndex == 0
      ? context.read<TaskManagementCubit>().allTasksModel?.data!.data!
      : selectedIndex == 1
          ? context.read<TaskManagementCubit>().pendingModel?.data!.items!
          : selectedIndex == 2
              ? context
                  .read<TaskManagementCubit>()
                  .inProgressModel
                  ?.data!
                  .items!
              : selectedIndex == 3
                  ? context
                      .read<TaskManagementCubit>()
                      .notApprovableModel
                      ?.data!
                      .items!
                  : selectedIndex == 4
                      ? context
                          .read<TaskManagementCubit>()
                          .rejectedModel
                          ?.data!
                          .items!
                      : selectedIndex == 5
                      ? context
                          .read<TaskManagementCubit>()
                          .completedModel
                          ?.data!
                          .items!
                      : selectedIndex == 6
                          ? context
                              .read<TaskManagementCubit>()
                              .notResolvedModel
                              ?.data!
                              .items!
                          : context
                              .read<TaskManagementCubit>()
                              .overdueModel
                              ?.data!
                              .items!;

  if (tasksData == null || tasksData.isEmpty) {
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
      itemCount: tasksData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCardItem(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
