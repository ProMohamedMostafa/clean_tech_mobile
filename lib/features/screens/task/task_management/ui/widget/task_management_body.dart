import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_list_details_build.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_management_filter_search_build.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';

class TaskManagementBody extends StatefulWidget {
  const TaskManagementBody({super.key});

  @override
  State<TaskManagementBody> createState() => _TaskManagementBodyState();
}

class _TaskManagementBodyState extends State<TaskManagementBody> {
  DateTime selectedDate = DateTime.now();
  List<String> tapList = [
    'All',
    'Pending',
    'In Progress',
    'Not Approval',
    'Rejected',
    'Completed',
    'Not Resolved',
    'Overdue',
    'Deleted'
  ];
  @override
  void initState() {
    context.read<TaskManagementCubit>().getAllTasks(startDate: selectedDate);
    context.read<TaskManagementCubit>().getArea();
    context.read<TaskManagementCubit>().getAllUsers();
    context.read<TaskManagementCubit>().getAllDeletedTasks();
    context.read<TaskManagementCubit>().getProviders();
    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        leading: customBackButton(context),
      ),
      floatingActionButton: role == 'Cleaner'
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 57.h,
                width: 57.w,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.addTaskScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: REdgeInsets.all(0),
                    backgroundColor: AppColor.primaryColor,
                    shape: CircleBorder(),
                    side: BorderSide(
                      color: AppColor.secondaryColor,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.post_add_outlined,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
            ),
      body: BlocConsumer<TaskManagementCubit, TaskManagementState>(
        listener: (context, state) {
          if (state is TaskDeleteSuccessState) {
            toast(text: state.deleteTaskModel.message!, color: Colors.blue);
            context
                .read<TaskManagementCubit>()
                .getAllTasks(startDate: selectedDate);
          }

          if (state is TaskDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is RestoreTaskSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<TaskManagementCubit>().getAllDeletedTasks();
          }

          if (state is RestoreTaskErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is ForceDeleteTaskSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<TaskManagementCubit>().getAllDeletedTasks();
          }

          if (state is ForceDeleteTaskErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          // final cubit = context.read<TaskManagementCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: taskManagementFilterAndSearchBuild(
                        context,
                        context.read<TaskManagementCubit>(),
                        selectedIndex,
                        selectedDate),
                  ),
                  verticalSpace(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: timePicker(context),
                  ),
                  verticalSpace(15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: taskCategories(),
                    ),
                  ),
                  verticalSpace(15),
                  // (state is GetAllTasksLoadingState ||
                  //         state is GetPendingTasksLoadingState ||
                  //         state is GetInProgressTasksLoadingState ||
                  //         state is GetNotApprovableTasksLoadingState ||
                  //         state is GetCompletedTasksLoadingState ||
                  //         state is GetNotResolvedTasksLoadingState ||
                  //         state is GetOverdueTasksLoadingState ||
                  //         cubit.allTasksModel == null ||
                  //         cubit.pendingModel == null ||
                  //         cubit.inProgressModel == null ||
                  //         cubit.notApprovableModel == null ||
                  //         cubit.completedModel == null ||
                  //         cubit.notResolvedModel == null ||
                  //         cubit.overdueModel == null)
                  //     ? Center(
                  //         child: CircularProgressIndicator(
                  //             color: AppColor.primaryColor),
                  //       ):
                  taskListDetailsBuild(context, selectedIndex!, selectedDate),
                  verticalSpace(30)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget taskCategories() {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return horizontalSpace(10);
        },
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tapList.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                index == 0
                    ? context
                        .read<TaskManagementCubit>()
                        .getAllTasks(startDate: selectedDate)
                    : index == 1
                        ? context
                            .read<TaskManagementCubit>()
                            .getPendingTasks(selectedDate)
                        : index == 2
                            ? context
                                .read<TaskManagementCubit>()
                                .getInProgressTasks(selectedDate)
                            : index == 3
                                ? context
                                    .read<TaskManagementCubit>()
                                    .getNotApprovableTasks(selectedDate)
                                : index == 4
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .getRejectedTasks(selectedDate)
                                    : index == 5
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .getCompletedTasks(selectedDate)
                                        : index == 6
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .getNotResolvedTasks(
                                                    selectedDate)
                                            : index == 7
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .getOverdueTasks(
                                                        selectedDate)
                                                : context
                                                    .read<TaskManagementCubit>()
                                                    .getAllDeletedTasks();
              });
            },
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColor.secondaryColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  tapList[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected ? Colors.white : AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget timePicker(BuildContext context) {
    return EasyDateTimeLinePicker.itemBuilder(
      headerOptions: HeaderOptions(
        headerType: HeaderType.none,
      ),
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(3000, 3, 18),
      focusedDate: selectedDate,
      itemExtent: 69.0,
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        String monthName = DateFormat.MMM().format(date);
        String weekdayName = DateFormat.E().format(date);

        return InkWell(
          onTap: onTap,
          child: Container(
            width: 44.w,
            height: 64.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: Colors.black12),
                color: isSelected ? AppColor.primaryColor : Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  monthName,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                Text(
                  weekdayName,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
              ],
            ),
          ),
        );
      },
      onDateChange: (date) {
        setState(() {
          selectedDate = date;
        });

        switch (selectedIndex) {
          case 0:
            context
                .read<TaskManagementCubit>()
                .getAllTasks(startDate: selectedDate);
            break;
          case 1:
            context.read<TaskManagementCubit>().getPendingTasks(selectedDate);
            break;
          case 2:
            context
                .read<TaskManagementCubit>()
                .getInProgressTasks(selectedDate);
            break;
          case 3:
            context
                .read<TaskManagementCubit>()
                .getNotApprovableTasks(selectedDate);
            break;
          case 4:
            context.read<TaskManagementCubit>().getRejectedTasks(selectedDate);
            break;
          case 5:
            context.read<TaskManagementCubit>().getCompletedTasks(selectedDate);
            break;
          case 6:
            context
                .read<TaskManagementCubit>()
                .getNotResolvedTasks(selectedDate);
            break;
          case 7:
            context.read<TaskManagementCubit>().getOverdueTasks(selectedDate);
            break;
          case 8:
            context.read<TaskManagementCubit>().getAllDeletedTasks();
            break;
        }
      },
    );
  }
}
