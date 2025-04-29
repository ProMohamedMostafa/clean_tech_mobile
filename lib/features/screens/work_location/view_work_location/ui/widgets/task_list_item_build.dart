import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/logic/cubit/work_location_details_cubit.dart';

Widget buildTaskCardItem(BuildContext context, index, selectedIndex) {
  final List<String> priority = ["High", "Medium", "Low"];
  final List<Color> priorityColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  String taskPriority;
  Color priorityColorForTask;

  taskPriority = selectedIndex == 0
      ? context
          .read<WorkLocationDetailsCubit>()
          .allareaTasksModel!
          .data!
          .data![index]
          .priority!
      : selectedIndex == 1
          ? context
              .read<WorkLocationDetailsCubit>()
              .allcityTasksModel!
              .data!
              .data![index]
              .priority!
          : selectedIndex == 2
              ? context
                  .read<WorkLocationDetailsCubit>()
                  .allorganizationTasksModel!
                  .data!
                  .data![index]
                  .priority!
              : selectedIndex == 3
                  ? context
                      .read<WorkLocationDetailsCubit>()
                      .allbuildingTasksModel!
                      .data!
                      .data![index]
                      .priority!
                  : selectedIndex == 4
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .allfloorTasksModel!
                          .data!
                          .data![index]
                          .priority!
                      : selectedIndex == 5
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allSectionTasksModel!
                              .data!
                              .data![index]
                              .priority!
                          : context
                              .read<WorkLocationDetailsCubit>()
                              .allPointTasksModel!
                              .data!
                              .data![index]
                              .priority!;

  // Find the color based on the priority value
  if (priority.contains(taskPriority)) {
    priorityColorForTask = priorityColor[priority.indexOf(taskPriority)];
  } else {
    priorityColorForTask = Colors.black;
  }
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(Routes.taskDetailsScreen,
          arguments: selectedIndex == 0
              ? context
                  .read<WorkLocationDetailsCubit>()
                  .allareaTasksModel!
                  .data!
                  .data![index]
                  .id!
              : selectedIndex == 1
                  ? context
                      .read<WorkLocationDetailsCubit>()
                      .allcityTasksModel!
                      .data!
                      .data![index]
                      .id!
                  : selectedIndex == 2
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .allorganizationTasksModel!
                          .data!
                          .data![index]
                          .id!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allbuildingTasksModel!
                              .data!
                              .data![index]
                              .id!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allfloorTasksModel!
                                  .data!
                                  .data![index]
                                  .id!
                              : selectedIndex == 5
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allSectionTasksModel!
                                      .data!
                                      .data![index]
                                      .id!
                                  : context
                                      .read<WorkLocationDetailsCubit>()
                                      .allPointTasksModel!
                                      .data!
                                      .data![index]
                                      .id!);
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 150.h,
        ),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, role == 'Admin' ? 0 : 10, 10, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: AppColor.secondaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 23.h,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: priorityColorForTask.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allareaTasksModel!
                              .data!
                              .data![index]
                              .priority!
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allcityTasksModel!
                                  .data!
                                  .data![index]
                                  .priority!
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allorganizationTasksModel!
                                      .data!
                                      .data![index]
                                      .priority!
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allbuildingTasksModel!
                                          .data!
                                          .data![index]
                                          .priority!
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .allfloorTasksModel!
                                              .data!
                                              .data![index]
                                              .priority!
                                          : selectedIndex == 5
                                              ? context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .allSectionTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .priority!
                                              : context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .allPointTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .priority!,
                      style: TextStyles.font11WhiteSemiBold.copyWith(
                        color: priorityColorForTask,
                      ),
                    ),
                  ),
                ),
                horizontalSpace(5),
                Container(
                  height: 23.h,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffD3DCF9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allareaTasksModel!
                              .data!
                              .data![index]
                              .status!
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allcityTasksModel!
                                  .data!
                                  .data![index]
                                  .status!
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allorganizationTasksModel!
                                      .data!
                                      .data![index]
                                      .status!
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allbuildingTasksModel!
                                          .data!
                                          .data![index]
                                          .status!
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .allfloorTasksModel!
                                              .data!
                                              .data![index]
                                              .status!
                                          : selectedIndex == 5
                                              ? context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .allSectionTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .status!
                                              : context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .allPointTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .status!,
                      style: TextStyles.font11WhiteSemiBold
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Spacer(),
                if (role == 'Admin')
                  IconButton(
                    onPressed: () {
                      PopUpDialog.show(
                          context: context,
                          id: selectedIndex == 0
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allareaTasksModel!
                                  .data!
                                  .data![index]
                                  .id!
                              : selectedIndex == 1
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allcityTasksModel!
                                      .data!
                                      .data![index]
                                      .id!
                                  : selectedIndex == 2
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allorganizationTasksModel!
                                          .data!
                                          .data![index]
                                          .id!
                                      : selectedIndex == 3
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .allbuildingTasksModel!
                                              .data!
                                              .data![index]
                                              .id!
                                          : selectedIndex == 4
                                              ? context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .allfloorTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .id!
                                              : selectedIndex == 5
                                                  ? context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .allSectionTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .id!
                                                  : context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .allPointTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .id!);
                    },
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      size: 22.sp,
                    ),
                  )
              ],
            ),
            Text(
              selectedIndex == 0
                  ? context
                      .read<WorkLocationDetailsCubit>()
                      .allareaTasksModel!
                      .data!
                      .data![index]
                      .title!
                  : selectedIndex == 1
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .allcityTasksModel!
                          .data!
                          .data![index]
                          .title!
                      : selectedIndex == 2
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allorganizationTasksModel!
                              .data!
                              .data![index]
                              .title!
                          : selectedIndex == 3
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allbuildingTasksModel!
                                  .data!
                                  .data![index]
                                  .title!
                              : selectedIndex == 4
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allfloorTasksModel!
                                      .data!
                                      .data![index]
                                      .title!
                                  : selectedIndex == 5
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allSectionTasksModel!
                                          .data!
                                          .data![index]
                                          .title!
                                      : context
                                          .read<WorkLocationDetailsCubit>()
                                          .allPointTasksModel!
                                          .data!
                                          .data![index]
                                          .title!,
              style: TextStyles.font16BlackSemiBold,
            ),
            verticalSpace(10),
            Text(
              selectedIndex == 0
                  ? context
                      .read<WorkLocationDetailsCubit>()
                      .allareaTasksModel!
                      .data!
                      .data![index]
                      .description!
                  : selectedIndex == 1
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .allcityTasksModel!
                          .data!
                          .data![index]
                          .description!
                      : selectedIndex == 2
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allorganizationTasksModel!
                              .data!
                              .data![index]
                              .description!
                          : selectedIndex == 3
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allbuildingTasksModel!
                                  .data!
                                  .data![index]
                                  .description!
                              : selectedIndex == 4
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allfloorTasksModel!
                                      .data!
                                      .data![index]
                                      .description!
                                  : selectedIndex == 5
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allSectionTasksModel!
                                          .data!
                                          .data![index]
                                          .description!
                                      : context
                                          .read<WorkLocationDetailsCubit>()
                                          .allPointTasksModel!
                                          .data!
                                          .data![index]
                                          .description!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyles.font11GreyMedium,
            ),
            verticalSpace(20),
            Row(
              children: [
                Icon(
                  IconBroken.timeCircle,
                  color: AppColor.primaryColor,
                  size: 22.sp,
                ),
                horizontalSpace(5),
                Text(
                  selectedIndex == 0
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .allareaTasksModel!
                          .data!
                          .data![index]
                          .startTime!
                      : selectedIndex == 1
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .allcityTasksModel!
                              .data!
                              .data![index]
                              .startTime!
                          : selectedIndex == 2
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .allorganizationTasksModel!
                                  .data!
                                  .data![index]
                                  .startTime!
                              : selectedIndex == 3
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .allbuildingTasksModel!
                                      .data!
                                      .data![index]
                                      .startTime!
                                  : selectedIndex == 4
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .allfloorTasksModel!
                                          .data!
                                          .data![index]
                                          .startTime!
                                      : selectedIndex == 5
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .allSectionTasksModel!
                                              .data!
                                              .data![index]
                                              .startTime!
                                          : context
                                              .read<WorkLocationDetailsCubit>()
                                              .allPointTasksModel!
                                              .data!
                                              .data![index]
                                              .startTime!,
                  style: TextStyles.font11WhiteSemiBold
                      .copyWith(color: AppColor.primaryColor),
                ),
                Spacer(),
                Text(
                  "+1",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                horizontalSpace(25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 1.w),
                      ),
                    ),
                    // Second circle (overlapping)
                    Positioned(
                      left: -20,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 1.w),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
