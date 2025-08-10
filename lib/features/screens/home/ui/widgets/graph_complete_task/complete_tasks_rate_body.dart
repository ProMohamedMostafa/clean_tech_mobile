import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_pie_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

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
        List<(String, String)> userDropdownItems = cubit.usersBasicModel?.data
                ?.map(
                    (user) => (user.id.toString(), user.userName ?? 'Unknown'))
                .toList() ??
            [];
            String selectedUserName = cubit.selectedUserName ?? S.of(context).All_Users;

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilterHeader(
                    title: S.of(context).taskCompletionRate,
                    chartType: cubit.selectedChartTypeCompleteTask,
                    dateRange: cubit.selectedDateRangeCompleteTask,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeCompleteTask(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeUser(value);
                    },
                    filterDropdownLabel: selectedUserName,
                    filterDropdownItems: userDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedUser(int.parse(value));
                    },
                    scrollController: cubit.userScrollController,showOnlyYear: true,
                  ),
                  verticalSpace(10),
                  Expanded(
                    child: _buildChart(cubit),
                  ),
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
      case 'خط':
      case 'لکیر':
        return CompleteTasksLineChart(
          completeTaskData: completeTaskData,
        );
      case 'Bar':
      case 'شريط':
      case 'بار':
        return CompleteTasksBarChart(
          completeTaskData: completeTaskData,
        );
      case 'Pie':
      case 'دائري':
      case 'پائی':
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
