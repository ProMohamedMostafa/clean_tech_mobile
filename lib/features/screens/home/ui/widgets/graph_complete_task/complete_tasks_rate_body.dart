import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_pie_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';

class CompleteTasksRateBody extends StatelessWidget {
  const CompleteTasksRateBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final isLoading = state is CompletetionTaskLoadingState ||
            cubit.completetionTaskModel == null;
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
                    title: 'Task completion rate',
                    chartType: cubit.selectedChartTypeCompleteTask,
                    dateRange: cubit.selectedDateRangeCompleteTask,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeCompleteTask(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeUser(value);
                    },
                    filterDropdownLabel: cubit.selectedUserName,
                    filterDropdownItems: userDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedUser(int.parse(value));
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
    final completeTaskData = cubit.completetionTaskModel;
    switch (cubit.selectedChartTypeCompleteTask) {
      case 'Line':
        return CompleteTasksLineChart(
          completeTaskData: completeTaskData,
        );
      case 'Bar':
        return CompleteTasksBarChart(
          completeTaskData: completeTaskData,
        );
      case 'Pie':
        return CompleteTasksPieChart(
          completeTaskData: completeTaskData,
        );
      default:
        return CompleteTasksLineChart(
          completeTaskData: completeTaskData,
        );
    }
  }
}
