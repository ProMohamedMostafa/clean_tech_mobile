import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/ui/widget/task_list_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TaskManagementBody extends StatelessWidget {
  final int index;
  const TaskManagementBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskManagementCubit>();

    return Scaffold(
      appBar:
          AppBar(title: Text(S.of(context).tasks), leading: CustomBackButton()),
      floatingActionButton: role == 'Cleaner'
          ? SizedBox.shrink()
          : floatingActionButton(
              icon: Icons.post_add_outlined,
              onPressed: () async {
                final result = await context.pushNamed(Routes.addTaskScreen);

                if (result == true) {
                  cubit.refreshTasks(index);
                }
              },
            ),
      body: BlocConsumer<TaskManagementCubit, TaskManagementState>(
        listener: (context, state) {
          if (state is GetAllTasksErrorState || state is TaskDeleteErrorState) {
            final errorMessage = state is GetAllTasksErrorState
                ? state.error
                : (state as TaskDeleteErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }
          if (state is ForceDeleteTaskSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getAllTasks(index);
            cubit.getAllDeletedTasks();
          }
          if (state is ForceDeleteTaskErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreTaskSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreTaskErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is TaskDeleteSuccessState) {
            toast(text: state.deleteTaskModel.message!, isSuccess: true);
            cubit.getAllDeletedTasks();
          }
          if (state is TaskDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                FilterAndSearchWidget(
                  hintText: S.of(context).find_task,
                  searchController: cubit.searchController,
                  onSearchChanged: (value) {
                    cubit.getAllTasks(index);
                  },
                  onFilterTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return BlocProvider(
                            create: (context) => FilterDialogCubit()
                              ..getArea()
                              ..getUsers()
                              ..getProviders()
                              ..getDevices(),
                            child: FilterDialogWidget(
                              index: 'T',
                             onPressed: (data) {
  cubit.filterModel = data;
  cubit.filterStartDate = data.startDate;
  cubit.filterEndDate = data.endDate;
  cubit.getAllTasks(index);
}

                            ));
                      },
                    );
                  },
                ),
                verticalSpace(10),
                _buildDatePicker(context),
                verticalSpace(10),
                _buildTabBar(context),
                verticalSpace(10),
                Expanded(
                  child: TaskListBuild(
                    indexx: index,
                  ),
                ),
                verticalSpace(10)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
  final cubit = context.read<TaskManagementCubit>();
  return EasyDateTimeLinePicker.itemBuilder(
    headerOptions: HeaderOptions(headerType: HeaderType.none),
    firstDate: DateTime(2025, 1, 1),
    lastDate: DateTime(3000, 3, 18),
    focusedDate: cubit.selectedDate,
    itemExtent: 69.0,
    itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
      String monthName = DateFormat.MMM().format(date);
      String weekdayName = DateFormat.E().format(date);

      // check if this day is in filter range
      bool isInRange = false;
      if (cubit.filterStartDate != null && cubit.filterEndDate != null) {
        isInRange = date.isAfter(cubit.filterStartDate!.subtract(const Duration(days: 1))) &&
                    date.isBefore(cubit.filterEndDate!.add(const Duration(days: 1)));
      }

      Color backgroundColor = Colors.white;
      Color textColor = Colors.black;

      if (isSelected) {
        backgroundColor = AppColor.primaryColor;
        textColor = Colors.white;
      } else if (isInRange) {
        backgroundColor = AppColor.fourthColor;
        textColor = AppColor.primaryColor;
      }

      return InkWell(
        onTap: onTap,
        child: Container(
          width: 44.w,
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: Colors.black12),
            color: backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                monthName,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
              ),
              Text(
                date.day.toString(),
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              Text(
                weekdayName,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    },
    onDateChange: (date) {
  cubit.filterStartDate = null;
  cubit.filterEndDate = null;
  cubit.filterModel = null;
  cubit.selectedDate = date;
  cubit.currentPage = 1;
  cubit.allTasksModel = null;
  cubit.getAllTasks(index);
},

  );
}


  Widget _buildTabBar(BuildContext context) {
    final cubit = context.read<TaskManagementCubit>();
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cubit.getTapList(context).length,
        separatorBuilder: (context, index) => horizontalSpace(10),
        itemBuilder: (context, indexx) {
          final isSelected = cubit.selectedIndex == indexx;
          return GestureDetector(
            onTap: () => cubit.changeTap(indexx, context, index),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColor.secondaryColor,
                  width: 1.w,
                ),
              ),
              child: Center(
                child: Text(
                  cubit.getTapList(context)[indexx],
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
}
