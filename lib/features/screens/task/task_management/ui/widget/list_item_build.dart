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

Widget buildCardItem(BuildContext context, index) {
  final TaskManagementCubit cubit = context.read<TaskManagementCubit>();
  final List<String> priority = ["High", "Medium", "Low"];
  final List<Color> priorityColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  String taskPriority;
  Color priorityColorForTask;
  if (cubit.selectedIndex == 8) {
    taskPriority = cubit.deleteTaskListModel!.data![index].priority!;
  } else {
    taskPriority = cubit.allTasksModel!.data!.data![index].priority!;
  }

  // Find the color based on the priority value
  if (priority.contains(taskPriority)) {
    priorityColorForTask = priorityColor[priority.indexOf(taskPriority)];
  } else {
    priorityColorForTask = Colors.black;
  }
  return InkWell(
    onTap: () {
      context.pushNamed(Routes.taskDetailsScreen,
          arguments: cubit.allTasksModel!.data!.data![index].id!);
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
                      cubit.selectedIndex == 8
                          ? cubit.deleteTaskListModel!.data![index].priority!
                          : cubit.allTasksModel!.data!.data![index].priority!,
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
                      cubit.selectedIndex == 8
                          ? cubit.deleteTaskListModel!.data![index].status!
                          : cubit.allTasksModel!.data!.data![index].status!,
                      style: TextStyles.font11WhiteSemiBold
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Spacer(),
                role == 'Cleaner'
                    ? horizontalSpace(30)
                    : cubit.selectedIndex == 8
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
                                id: context
                                    .read<TaskManagementCubit>()
                                    .allTasksModel!
                                    .data!
                                    .data![index]
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
              cubit.selectedIndex == 8
                  ? context
                      .read<TaskManagementCubit>()
                      .deleteTaskListModel!
                      .data![index]
                      .title!
                  : context
                      .read<TaskManagementCubit>()
                      .allTasksModel!
                      .data!
                      .data![index]
                      .title!,
              style: TextStyles.font16BlackSemiBold,
            ),
            verticalSpace(10),
            Text(
              cubit.selectedIndex == 8
                  ? context
                      .read<TaskManagementCubit>()
                      .deleteTaskListModel!
                      .data![index]
                      .description!
                  : context
                      .read<TaskManagementCubit>()
                      .allTasksModel!
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
                  cubit.selectedIndex == 8
                      ? context
                          .read<TaskManagementCubit>()
                          .deleteTaskListModel!
                          .data![index]
                          .startTime!
                      : context
                          .read<TaskManagementCubit>()
                          .allTasksModel!
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
                      //     child: Image.network(
                      //       '${ApiConstants.apiBaseUrl}${cubit.selectedIndex == 0
                      // ? context
                      //     .read<TaskManagementCubit>()
                      //     .allTasksModel!
                      //     .data!
                      //     .data![index]
                      //   .title!
                      // : cubit.selectedIndex == 1
                      //     ? context
                      //         .read<TaskManagementCubit>()
                      //         .pendingModel!
                      //         .data!
                      //         .data![index]
                      //       .title!
                      //     : cubit.selectedIndex == 2
                      //         ? context
                      //             .read<TaskManagementCubit>()
                      //             .inProgressModel!
                      //             .data!
                      //             .data![index]
                      //           .title!
                      //         : cubit.selectedIndex == 3
                      //             ? context
                      //                 .read<TaskManagementCubit>()
                      //                 .notApprovableModel!
                      //                 .data!
                      //                 .data![index]
                      //               .title!
                      //             : cubit.selectedIndex == 4
                      //                 ? context
                      //                     .read<TaskManagementCubit>()
                      //                     .rejectedModel!
                      //                     .data!
                      //                     .data![index]
                      //                   .title!
                      //                 : cubit.selectedIndex == 5
                      //                     ? context
                      //                         .read<TaskManagementCubit>()
                      //                         .completedModel!
                      //                         .data!
                      //                         .data![index]
                      //                       .title!
                      //                     : cubit.selectedIndex == 6
                      //                         ? context
                      //                             .read<TaskManagementCubit>()
                      //                             .notResolvedModel!
                      //                             .data!
                      //                             .data![index]
                      //                           .title!
                      //                         : cubit.selectedIndex == 7
                      //                             ? context
                      //                                 .read<TaskManagementCubit>()
                      //                                 .overdueModel!
                      //                                 .data!
                      //                                 .data![index]
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
  );
}
