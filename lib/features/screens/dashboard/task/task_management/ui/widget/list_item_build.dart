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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/ui/widget/pop_up_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TaskListItemBuild extends StatelessWidget {
  final int index;
  final int selectedIndex;
  const TaskListItemBuild(
      {super.key, required this.index, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskManagementCubit>();
    final String taskPriority = cubit.selectedIndex == 8
        ? cubit.deleteTaskListModel!.data![index].priority!
        : cubit.allTasksModel!.data!.data![index].priority!;

    final Color priorityColorForTask = cubit.getPriorityColor(taskPriority);
    String formatTime(String? time) {
      if (time == null || time.isEmpty) return "--:--";
      return time.substring(0, 5);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(
          Routes.taskDetailsScreen,
          arguments: {
            'id': cubit.allTasksModel!.data!.data![index].id!,
            'selectedIndex': selectedIndex
          },
        );

        if (result == true) {
          cubit.refreshTasks(selectedIndex);
        }
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
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
                        taskPriority,
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
                  (role == 'Cleaner' ||
                          (role != 'Admin' &&
                              cubit.allTasksModel!.data!.data![index]
                                      .createdBy !=
                                  uId) ||
                          selectedIndex == 2)
                      ? horizontalSpace(30)
                      : cubit.selectedIndex == 8
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return PopUpMessage(
                                              title: S.of(context).TitleRestore,
                                              body: S.of(context).taskbody,
                                              onPressed: () {
                                                cubit.restoreDeletedTask(cubit
                                                    .deleteTaskListModel!
                                                    .data![index]
                                                    .id!);
                                              });
                                        });
                                  },
                                  child: Icon(
                                    Icons.replay_outlined,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                horizontalSpace(8),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return PopUpMessage(
                                              title: S.of(context).TitleDelete,
                                              body: S.of(context).taskbody,
                                              onPressed: () {
                                                cubit.selectedIndex == 8
                                                    ? cubit.forcedDeletedUser(
                                                        cubit
                                                            .deleteTaskListModel!
                                                            .data![index]
                                                            .id!)
                                                    : cubit.taskDelete(
                                                        cubit
                                                            .deleteTaskListModel!
                                                            .data![index]
                                                            .id!,
                                                        selectedIndex);
                                              });
                                        });
                                  },
                                  child: Icon(
                                    IconBroken.delete,
                                    color: Colors.red,
                                    size: 24.sp,
                                  ),
                                ),
                              ],
                            )
                          : IconButton(
                              onPressed: () {
                                PopUpDialog.show(
                                  context: context,
                                  id: cubit
                                      .allTasksModel!.data!.data![index].id!,
                                );
                              },
                              icon: Icon(
                                Icons.more_horiz_rounded,
                                size: 22.sp,
                              ),
                            ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      cubit.selectedIndex == 8
                          ? cubit.deleteTaskListModel!.data![index].title!
                          : cubit.allTasksModel!.data!.data![index].title!,
                      style: TextStyles.font16BlackSemiBold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
              Text(
                cubit.selectedIndex == 8
                    ? cubit.deleteTaskListModel!.data![index].description!
                    : cubit.allTasksModel!.data!.data![index].description!,
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cubit.selectedIndex == 8
                              ? formatTime(cubit
                                  .deleteTaskListModel?.data?[index].startTime)
                              : formatTime(cubit
                                  .allTasksModel?.data?.data?[index].startTime),
                          style: TextStyles.font11PrimMedium,
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyles.font11BlackMedium,
                        ),
                        TextSpan(
                          text: cubit.selectedIndex == 8
                              ? cubit
                                  .deleteTaskListModel!.data![index].startDate!
                              : cubit
                                  .allTasksModel!.data!.data![index].startDate!,
                          style: TextStyles.font11PrimMedium,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  buildUserAvatars(cubit, index),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserAvatars(TaskManagementCubit cubit, int index) {
    final dynamic users = cubit.selectedIndex == 8
        ? (cubit.deleteTaskListModel?.data?[index].users ?? [])
        : (cubit.allTasksModel?.data?.data?[index].users ?? []);

    final visibleUsers = users.take(2).toList();
    final extraCount = users.length - visibleUsers.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (extraCount > 0)
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              '+$extraCount',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          width: users.length == 1 ? 30.w : 50.w,
          height: 30.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(visibleUsers.length, (i) {
              final user = visibleUsers[i];
              final imageUrl = cubit.selectedIndex == 8
                  ? (user as DeleteTaskUser).image
                  : (user as UserModel).image;
              return Positioned(
                left: i * 20.0,
                child: Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.w),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
