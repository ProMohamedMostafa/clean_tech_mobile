import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_pie_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TotalTaskBody extends StatelessWidget {
  const TotalTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final isLoading = state is TaskStatusLoadingState ||
            cubit.taskChartStatusModel == null;

        final totalTask = cubit.taskChartStatusModel?.data?.values
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
                    title: S.of(context).totalTask,
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
                    extraWidget: PrioritySelector(
                      role: role!,
                      onPrioritySelected: (priorityValue) {
                        cubit.getChartTaskData(priority: priorityValue);
                      },
                    ),
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
    final taskData = cubit.taskChartStatusModel;
    switch (cubit.selectedChartTypeTask) {
      case 'Line':
      case 'خط':
      case 'لکیر':
        return TotalTaskLineChart(
          taskData: taskData,
        );
      case 'Bar':
      case 'شريط':
      case 'بار':
        return TotalTaskBarChart(
          taskData: taskData,
        );
      case 'Pie':
      case 'دائري':
      case 'پائی':
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

class PrioritySelector extends StatelessWidget {
  final String role;
  final Function(int priority)? onPrioritySelected;

  const PrioritySelector({
    super.key,
    required this.role,
    this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    if (role != 'Cleaner') return const SizedBox.shrink();

    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: cubit.priorityColors[cubit.selectedPriority]!.withOpacity(0.1),
        border:
            Border.all(color: cubit.priorityColors[cubit.selectedPriority]!),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          color: Colors.white,
          menuPadding: EdgeInsets.zero,
          itemBuilder: (context) {
            return cubit.priorities.map((priority) {
              return PopupMenuItem<String>(
                value: priority,
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  priority,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: cubit.priorityColors[priority],
                  ),
                ),
              );
            }).toList();
          },
          onSelected: (value) {
            cubit.selectedPriority = value;

            final int? priorityValue = cubit.convertPriorityToInt(value);
            if (priorityValue != null && onPrioritySelected != null) {
              onPrioritySelected!(priorityValue);
            }
          },
          offset: Offset(10, 22.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cubit.selectedPriority,
                  style: TextStyle(
                    color: cubit.priorityColors[cubit.selectedPriority],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                horizontalSpace(4.w),
                Icon(
                  IconBroken.arrowDown2,
                  color: cubit.priorityColors[cubit.selectedPriority],
                  size: 18.sp,
                ),
              ],
            ),
          )),
    );
  }
}
