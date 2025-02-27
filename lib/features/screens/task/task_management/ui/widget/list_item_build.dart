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
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/pop_up_dialog.dart';

Widget buildCardItem(BuildContext context, selectedIndex, index) {
  final List<String> priority = ["High", "Medium", "Low"];
  final List<Color> priorityColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  String taskPriority;
  Color priorityColorForTask;

  if (selectedIndex == 0) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .allTasksModel!
        .data!
        .data![index]
        .priority!;
  } else if (selectedIndex == 1) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .pendingModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 2) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .inProgressModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 3) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .notApprovableModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 4) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .rejectedModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 5) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .completedModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 6) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .notResolvedModel!
        .data!
        .items![index]
        .priority!;
  } else if (selectedIndex == 7) {
    taskPriority = context
        .read<TaskManagementCubit>()
        .overdueModel!
        .data!
        .items![index]
        .priority!;
  } else {
    taskPriority = context
        .read<TaskManagementCubit>()
        .deleteTaskListModel!
        .data![index]
        .priority!;
  }

  // Find the color based on the priority value
  if (priority.contains(taskPriority)) {
    priorityColorForTask = priorityColor[priority.indexOf(taskPriority)];
  } else {
    priorityColorForTask = Colors.black;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: () {
        context.pushNamed(Routes.taskDetailsScreen,
            arguments: selectedIndex == 0
                ? context
                    .read<TaskManagementCubit>()
                    .allTasksModel!
                    .data!
                    .data![index]
                    .id!
                : selectedIndex == 1
                    ? context
                        .read<TaskManagementCubit>()
                        .pendingModel!
                        .data!
                        .items![index]
                        .id!
                    : selectedIndex == 2
                        ? context
                            .read<TaskManagementCubit>()
                            .inProgressModel!
                            .data!
                            .items![index]
                            .id!
                        : selectedIndex == 3
                            ? context
                                .read<TaskManagementCubit>()
                                .notApprovableModel!
                                .data!
                                .items![index]
                                .id!
                            : selectedIndex == 4
                                ? context
                                    .read<TaskManagementCubit>()
                                    .rejectedModel!
                                    .data!
                                    .items![index]
                                    .id!
                                : selectedIndex == 5
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .completedModel!
                                        .data!
                                        .items![index]
                                        .id!
                                    : selectedIndex == 6
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .notResolvedModel!
                                            .data!
                                            .items![index]
                                            .id!
                                        : context
                                            .read<TaskManagementCubit>()
                                            .overdueModel!
                                            .data!
                                            .items![index]
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
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                                .read<TaskManagementCubit>()
                                .allTasksModel!
                                .data!
                                .data![index]
                                .priority!
                            : selectedIndex == 1
                                ? context
                                    .read<TaskManagementCubit>()
                                    .pendingModel!
                                    .data!
                                    .items![index]
                                    .priority!
                                : selectedIndex == 2
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .inProgressModel!
                                        .data!
                                        .items![index]
                                        .priority!
                                    : selectedIndex == 3
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .notApprovableModel!
                                            .data!
                                            .items![index]
                                            .priority!
                                        : selectedIndex == 4
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .rejectedModel!
                                                .data!
                                                .items![index]
                                                .priority!
                                            : selectedIndex == 5
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .completedModel!
                                                    .data!
                                                    .items![index]
                                                    .priority!
                                                : selectedIndex == 6
                                                    ? context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .notResolvedModel!
                                                        .data!
                                                        .items![index]
                                                        .priority!
                                                    : selectedIndex == 7
                                                        ? context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .overdueModel!
                                                            .data!
                                                            .items![index]
                                                            .priority!
                                                        : context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .deleteTaskListModel!
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
                                .read<TaskManagementCubit>()
                                .allTasksModel!
                                .data!
                                .data![index]
                                .status!
                            : selectedIndex == 1
                                ? context
                                    .read<TaskManagementCubit>()
                                    .pendingModel!
                                    .data!
                                    .items![index]
                                    .status!
                                : selectedIndex == 2
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .inProgressModel!
                                        .data!
                                        .items![index]
                                        .status!
                                    : selectedIndex == 3
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .notApprovableModel!
                                            .data!
                                            .items![index]
                                            .status!
                                        : selectedIndex == 4
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .rejectedModel!
                                                .data!
                                                .items![index]
                                                .status!
                                            : selectedIndex == 5
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .completedModel!
                                                    .data!
                                                    .items![index]
                                                    .status!
                                                : selectedIndex == 6
                                                    ? context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .notResolvedModel!
                                                        .data!
                                                        .items![index]
                                                        .status!
                                                    : selectedIndex == 7
                                                        ? context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .overdueModel!
                                                            .data!
                                                            .items![index]
                                                            .status!
                                                        : context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .deleteTaskListModel!
                                                            .data![index]
                                                            .status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                  Spacer(),
                  role == 'Cleaner'
                      ? SizedBox.shrink()
                      : selectedIndex == 8
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showCustomDialog(context,
                                        "Are you Sure to restore this task ?",
                                        () {
                                      context
                                          .read<TaskManagementCubit>()
                                          .restoreDeletedTask(context
                                              .read<TaskManagementCubit>()
                                              .deleteTaskListModel!
                                              .data![index]
                                              .id!);
                                      context.pop();
                                    });
                                  },
                                  child: Icon(
                                    Icons.replay_outlined,
                                    size: 26,
                                    color: AppColor.thirdColor,
                                  ),
                                ),
                                horizontalSpace(8),
                                InkWell(
                                  onTap: () {
                                    showCustomDialog(
                                        context, "Forced Delete this task", () {
                                      context
                                          .read<TaskManagementCubit>()
                                          .restoreDeletedTask(context
                                              .read<TaskManagementCubit>()
                                              .deleteTaskListModel!
                                              .data![index]
                                              .id!);
                                      context.pop();
                                    });
                                  },
                                  child: Icon(
                                    IconBroken.delete,
                                    color: AppColor.thirdColor,
                                  ),
                                ),
                                horizontalSpace(5),
                              ],
                            )
                          : IconButton(
                              onPressed: () {
                                PopUpDialog.show(
                                  context: context,
                                  id: selectedIndex == 0
                                      ? context
                                          .read<TaskManagementCubit>()
                                          .allTasksModel!
                                          .data!
                                          .data![index]
                                          .id!
                                      : selectedIndex == 1
                                          ? context
                                              .read<TaskManagementCubit>()
                                              .pendingModel!
                                              .data!
                                              .items![index]
                                              .id!
                                          : selectedIndex == 2
                                              ? context
                                                  .read<TaskManagementCubit>()
                                                  .inProgressModel!
                                                  .data!
                                                  .items![index]
                                                  .id!
                                              : selectedIndex == 3
                                                  ? context
                                                      .read<
                                                          TaskManagementCubit>()
                                                      .notApprovableModel!
                                                      .data!
                                                      .items![index]
                                                      .id!
                                                  : selectedIndex == 4
                                                      ? context
                                                          .read<
                                                              TaskManagementCubit>()
                                                          .rejectedModel!
                                                          .data!
                                                          .items![index]
                                                          .id!
                                                      : selectedIndex == 5
                                                          ? context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .completedModel!
                                                              .data!
                                                              .items![index]
                                                              .id!
                                                          : selectedIndex == 6
                                                              ? context
                                                                  .read<
                                                                      TaskManagementCubit>()
                                                                  .notResolvedModel!
                                                                  .data!
                                                                  .items![index]
                                                                  .id!
                                                              : context
                                                                  .read<
                                                                      TaskManagementCubit>()
                                                                  .overdueModel!
                                                                  .data!
                                                                  .items![index]
                                                                  .id!,
                                );
                              },
                              icon: Icon(
                                Icons.more_horiz_rounded,
                                size: 22.sp,
                              ),
                            ),
                ],
              ),
              Text(
                selectedIndex == 0
                    ? context
                        .read<TaskManagementCubit>()
                        .allTasksModel!
                        .data!
                        .data![index]
                        .title!
                    : selectedIndex == 1
                        ? context
                            .read<TaskManagementCubit>()
                            .pendingModel!
                            .data!
                            .items![index]
                            .title!
                        : selectedIndex == 2
                            ? context
                                .read<TaskManagementCubit>()
                                .inProgressModel!
                                .data!
                                .items![index]
                                .title!
                            : selectedIndex == 3
                                ? context
                                    .read<TaskManagementCubit>()
                                    .notApprovableModel!
                                    .data!
                                    .items![index]
                                    .title!
                                : selectedIndex == 4
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .rejectedModel!
                                        .data!
                                        .items![index]
                                        .title!
                                    : selectedIndex == 5
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .completedModel!
                                            .data!
                                            .items![index]
                                            .title!
                                        : selectedIndex == 6
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .notResolvedModel!
                                                .data!
                                                .items![index]
                                                .title!
                                            : selectedIndex == 7
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .overdueModel!
                                                    .data!
                                                    .items![index]
                                                    .title!
                                                : context
                                                    .read<TaskManagementCubit>()
                                                    .deleteTaskListModel!
                                                    .data![index]
                                                    .title!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                selectedIndex == 0
                    ? context
                        .read<TaskManagementCubit>()
                        .allTasksModel!
                        .data!
                        .data![index]
                        .description!
                    : selectedIndex == 1
                        ? context
                            .read<TaskManagementCubit>()
                            .pendingModel!
                            .data!
                            .items![index]
                            .description!
                        : selectedIndex == 2
                            ? context
                                .read<TaskManagementCubit>()
                                .inProgressModel!
                                .data!
                                .items![index]
                                .description!
                            : selectedIndex == 3
                                ? context
                                    .read<TaskManagementCubit>()
                                    .notApprovableModel!
                                    .data!
                                    .items![index]
                                    .description!
                                : selectedIndex == 4
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .rejectedModel!
                                        .data!
                                        .items![index]
                                        .description!
                                    : selectedIndex == 5
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .completedModel!
                                            .data!
                                            .items![index]
                                            .description!
                                        : selectedIndex == 6
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .notResolvedModel!
                                                .data!
                                                .items![index]
                                                .description!
                                            : selectedIndex == 7
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .overdueModel!
                                                    .data!
                                                    .items![index]
                                                    .description!
                                                : context
                                                    .read<TaskManagementCubit>()
                                                    .deleteTaskListModel!
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
                            .read<TaskManagementCubit>()
                            .allTasksModel!
                            .data!
                            .data![index]
                            .startTime!
                        : selectedIndex == 1
                            ? context
                                .read<TaskManagementCubit>()
                                .pendingModel!
                                .data!
                                .items![index]
                                .startTime!
                            : selectedIndex == 2
                                ? context
                                    .read<TaskManagementCubit>()
                                    .inProgressModel!
                                    .data!
                                    .items![index]
                                    .startTime!
                                : selectedIndex == 3
                                    ? context
                                        .read<TaskManagementCubit>()
                                        .notApprovableModel!
                                        .data!
                                        .items![index]
                                        .startTime!
                                    : selectedIndex == 4
                                        ? context
                                            .read<TaskManagementCubit>()
                                            .rejectedModel!
                                            .data!
                                            .items![index]
                                            .startTime!
                                        : selectedIndex == 5
                                            ? context
                                                .read<TaskManagementCubit>()
                                                .completedModel!
                                                .data!
                                                .items![index]
                                                .startTime!
                                            : selectedIndex == 6
                                                ? context
                                                    .read<TaskManagementCubit>()
                                                    .notResolvedModel!
                                                    .data!
                                                    .items![index]
                                                    .startTime!
                                                : selectedIndex == 7
                                                    ? context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .overdueModel!
                                                        .data!
                                                        .items![index]
                                                        .startTime!
                                                    : context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .deleteTaskListModel!
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
                        //     child: Image.network(
                        //       '${ApiConstants.apiBaseUrl}${selectedIndex == 0
                        // ? context
                        //     .read<TaskManagementCubit>()
                        //     .allTasksModel!
                        //     .data!
                        //     .data![index]
                        //   .title!
                        // : selectedIndex == 1
                        //     ? context
                        //         .read<TaskManagementCubit>()
                        //         .pendingModel!
                        //         .data!
                        //         .items![index]
                        //       .title!
                        //     : selectedIndex == 2
                        //         ? context
                        //             .read<TaskManagementCubit>()
                        //             .inProgressModel!
                        //             .data!
                        //             .items![index]
                        //           .title!
                        //         : selectedIndex == 3
                        //             ? context
                        //                 .read<TaskManagementCubit>()
                        //                 .notApprovableModel!
                        //                 .data!
                        //                 .items![index]
                        //               .title!
                        //             : selectedIndex == 4
                        //                 ? context
                        //                     .read<TaskManagementCubit>()
                        //                     .rejectedModel!
                        //                     .data!
                        //                     .items![index]
                        //                   .title!
                        //                 : selectedIndex == 5
                        //                     ? context
                        //                         .read<TaskManagementCubit>()
                        //                         .completedModel!
                        //                         .data!
                        //                         .items![index]
                        //                       .title!
                        //                     : selectedIndex == 6
                        //                         ? context
                        //                             .read<TaskManagementCubit>()
                        //                             .notResolvedModel!
                        //                             .data!
                        //                             .items![index]
                        //                           .title!
                        //                         : selectedIndex == 7
                        //                             ? context
                        //                                 .read<TaskManagementCubit>()
                        //                                 .overdueModel!
                        //                                 .data!
                        //                                 .items![index]
                        //                               .title!
                        //                             : context
                        //                                 .read<TaskManagementCubit>()
                        //                                 .deleteTaskListModel!
                        //                                 .data![index]
                        //                               .title!}',
                        //       fit: BoxFit.fill,
                        //       errorBuilder: (context, error, stackTrace) {
                        //         return Image.asset(
                        //           'assets/images/noImage.png',
                        //           fit: BoxFit.fill,
                        //         );
                        //       },
                        //     ),
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
    ),
  );
}
