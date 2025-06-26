import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TaskListBuild extends StatelessWidget {
  const TaskListBuild({super.key});

  @override
  Widget build(BuildContext context) {
     final cubit = context.read<TaskManagementCubit>();
    final itemCount = cubit.selectedIndex == 8
      ? cubit.deleteTaskListModel?.data?.length ?? 0
      : cubit.allTasksModel?.data?.data?.length ?? 0;

  if (itemCount == 0) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return ListView.separated(
    controller: cubit.selectedIndex == 8 ? null : cubit.scrollController,
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    separatorBuilder: (context, index) => verticalSpace(10),
    itemCount: itemCount,
    itemBuilder: (context, index) => Skeletonizer(
        enabled: cubit.allTasksModel == null,
        child: TaskListItemBuild(index: index)),
  );
  }
}

