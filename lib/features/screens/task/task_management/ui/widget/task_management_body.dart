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
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_list_details_build.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_management_filter_search_build.dart';

class TaskManagementBody extends StatelessWidget {
  const TaskManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        leading: CustomBackButton(),
      ),
      floatingActionButton: role == 'Cleaner'
          ? SizedBox.shrink()
          : floatingActionButton(
              icon: Icons.post_add_outlined,
              onPressed: () {
                context.pushNamed(Routes.addTaskScreen);
              },
            ),
      body: BlocConsumer<TaskManagementCubit, TaskManagementState>(
        listener: (context, state) {
          if (state is GetAllTasksErrorState || state is TaskDeleteErrorState) {
            final errorMessage = state is GetAllTasksErrorState
                ? state.error
                : (state as TaskDeleteErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is ForceDeleteTaskSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<TaskManagementCubit>().getAllTasks();
            context.read<TaskManagementCubit>().getAllDeletedTasks();
          }
          if (state is RestoreTaskSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is TaskDeleteSuccessState) {
            toast(text: state.deleteTaskModel.message!, color: Colors.blue);
            context.read<TaskManagementCubit>().getAllDeletedTasks();
          }
        },
        builder: (context, state) {
          TaskManagementCubit cubit = context.read<TaskManagementCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                FilterAndSearchWidget(),
                verticalSpace(10),
                _buildDatePicker(context),
                verticalSpace(10),
                _buildTabBar(context),
                verticalSpace(10),
                Expanded(
                  child: taskListDetailsBuild(context, state, cubit),
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
        return InkWell(
          onTap: onTap,
          child: Container(
            width: 44.w,
            height: 64.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.r),
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
        cubit.selectedDate = date;
        cubit.currentPage = 1;
        cubit.allTasksModel = null;
        cubit.getAllTasks();
      },
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final cubit = context.read<TaskManagementCubit>();
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cubit.tapList.length,
        separatorBuilder: (context, index) => horizontalSpace(10),
        itemBuilder: (context, index) {
          final isSelected = cubit.selectedIndex == index;
          return GestureDetector(
            onTap: () => cubit.changeTap(index),
            child: Container(
              height: 40.h,
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
                  cubit.tapList[index],
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
