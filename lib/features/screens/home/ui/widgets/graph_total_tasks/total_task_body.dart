import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_pie_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';

class TotalTaskBody extends StatelessWidget {
  const TotalTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final isLoading =
            state is TaskStatusLoadingState || cubit.taskStatusModel == null;

        final totalTask = cubit.taskStatusModel?.data?.values
                ?.fold<int>(0, (a, b) => a + b) ??
            0;
        List<(String, String)> userDropdownItems = cubit.usersModel?.data?.users
                ?.map(
                    (user) => (user.id.toString(), user.userName ?? 'Unknown'))
                .toList() ??
            [];
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterHeader(
                    title: 'Total Task',
                    count1: totalTask,
                    chartType: cubit.selectedChartTypeTask,
                    dateRange: cubit.selectedDateRangeTask,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeTask(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeUserTask(value);
                    },
                    filterDropdownLabel: cubit.selectedUserNametask,
                    filterDropdownItems: userDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedUsertask(int.parse(value));
                    },
                    scrollController: cubit.userScrollController,
                  ),
                  _buildChart(cubit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(HomeCubit cubit) {
    final taskData = cubit.taskStatusModel;
    switch (cubit.selectedChartTypeTask) {
      case 'Line':
        return TotalTaskLineChart(
          taskData: taskData,
        );
      case 'Bar':
        return TotalTaskBarChart(
          taskData: taskData,
        );
      case 'Pie':
        return TotalTaskPieChart(
          taskData: taskData,
        );
      default:
        return TotalTaskLineChart(
          taskData: taskData,
        );
    }
  }
}
