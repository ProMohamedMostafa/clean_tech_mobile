import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_tasks/work_location_task_item.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationTasks extends StatelessWidget {
  final int id;
  final int selectedIndex;
  const WorkLocationTasks({super.key, required this.selectedIndex, required this.id});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(10),
          _buildWorklocationTaskDetails(context),
        ],
      ),
    );
  }

  Widget _buildWorklocationTaskDetails(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final taskModel = selectedIndex == 0
        ? cubit.allAreaTasksModel
        : selectedIndex == 1
            ? cubit.allCityTasksModel
            : selectedIndex == 2
                ? cubit.allOrganizationTasksModel
                : selectedIndex == 3
                    ? cubit.allBuildingTasksModel
                    : selectedIndex == 4
                        ? cubit.allFloorTasksModel
                        : selectedIndex == 5
                            ? cubit.allSectionTasksModel
                            : cubit.allPointTasksModel;

    if (taskModel?.data?.data == null || taskModel!.data!.data!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: taskModel.data!.data!.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorkLocationTaskItem(selectedIndex: selectedIndex, index: index,id:id),
            ],
          );
        },
      );
    }
  }
}
