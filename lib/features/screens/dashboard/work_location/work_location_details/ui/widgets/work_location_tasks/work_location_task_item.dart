import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationTaskItem extends StatelessWidget {
  final int id;
  final int selectedIndex;
  final int index;
  const WorkLocationTaskItem(
      {super.key,
      required this.selectedIndex,
      required this.index,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();

    final List<String> priority = [
      S.of(context).high,
      S.of(context).medium,
      S.of(context).low
    ];
    final List<Color> priorityColor = [
      Colors.red,
      Colors.orange,
      Colors.green,
    ];
    String taskPriority;
    Color priorityColorForTask;

    taskPriority = selectedIndex == 0
        ? cubit.allAreaTasksModel!.data!.data![index].priority!
        : selectedIndex == 1
            ? cubit.allCityTasksModel!.data!.data![index].priority!
            : selectedIndex == 2
                ? cubit.allOrganizationTasksModel!.data!.data![index].priority!
                : selectedIndex == 3
                    ? cubit.allBuildingTasksModel!.data!.data![index].priority!
                    : selectedIndex == 4
                        ? cubit.allFloorTasksModel!.data!.data![index].priority!
                        : selectedIndex == 5
                            ? cubit.allSectionTasksModel!.data!.data![index]
                                .priority!
                            : cubit.allPointTasksModel!.data!.data![index]
                                .priority!;

    // Find the color based on the priority value
    if (priority.contains(taskPriority)) {
      priorityColorForTask = priorityColor[priority.indexOf(taskPriority)];
    } else {
      priorityColorForTask = Colors.black;
    }

    String formatTime(String? time) {
      if (time == null || time.isEmpty) return "--:--";
      return time.substring(0, 5); 
    }

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(Routes.taskDetailsScreen,
            arguments: selectedIndex == 0
                ? cubit.allAreaTasksModel!.data!.data![index].id!
                : selectedIndex == 1
                    ? cubit.allCityTasksModel!.data!.data![index].id!
                    : selectedIndex == 2
                        ? cubit
                            .allOrganizationTasksModel!.data!.data![index].id!
                        : selectedIndex == 3
                            ? cubit
                                .allBuildingTasksModel!.data!.data![index].id!
                            : selectedIndex == 4
                                ? cubit
                                    .allFloorTasksModel!.data!.data![index].id!
                                : selectedIndex == 5
                                    ? cubit.allSectionTasksModel!.data!
                                        .data![index].id!
                                    : cubit.allPointTasksModel!.data!
                                        .data![index].id!);

        if (result == true) {
          selectedIndex == 0
              ? cubit.getAreaTasks(id)
              : selectedIndex == 1
                  ? cubit.getCityTasks(id)
                  : selectedIndex == 2
                      ? cubit.getOrganizationTasks(id)
                      : selectedIndex == 3
                          ? cubit.getBuildingTasks(id)
                          : selectedIndex == 4
                              ? cubit.getFloorTasks(id)
                              : selectedIndex == 5
                                  ? cubit.getSectionTasks(id)
                                  : cubit.getPointTasks(id);
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
                        selectedIndex == 0
                            ? cubit
                                .allAreaTasksModel!.data!.data![index].priority!
                            : selectedIndex == 1
                                ? cubit.allCityTasksModel!.data!.data![index]
                                    .priority!
                                : selectedIndex == 2
                                    ? cubit.allOrganizationTasksModel!.data!
                                        .data![index].priority!
                                    : selectedIndex == 3
                                        ? cubit.allBuildingTasksModel!.data!
                                            .data![index].priority!
                                        : selectedIndex == 4
                                            ? cubit.allFloorTasksModel!.data!
                                                .data![index].priority!
                                            : selectedIndex == 5
                                                ? cubit
                                                    .allSectionTasksModel!
                                                    .data!
                                                    .data![index]
                                                    .priority!
                                                : cubit
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
                            ? cubit
                                .allAreaTasksModel!.data!.data![index].status!
                            : selectedIndex == 1
                                ? cubit.allCityTasksModel!.data!.data![index]
                                    .status!
                                : selectedIndex == 2
                                    ? cubit.allOrganizationTasksModel!.data!
                                        .data![index].status!
                                    : selectedIndex == 3
                                        ? cubit.allBuildingTasksModel!.data!
                                            .data![index].status!
                                        : selectedIndex == 4
                                            ? cubit.allFloorTasksModel!.data!
                                                .data![index].status!
                                            : selectedIndex == 5
                                                ? cubit.allSectionTasksModel!
                                                    .data!.data![index].status!
                                                : cubit.allPointTasksModel!
                                                    .data!.data![index].status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedIndex == 0
                          ? cubit.allAreaTasksModel!.data!.data![index].title!
                          : selectedIndex == 1
                              ? cubit
                                  .allCityTasksModel!.data!.data![index].title!
                              : selectedIndex == 2
                                  ? cubit.allOrganizationTasksModel!.data!
                                      .data![index].title!
                                  : selectedIndex == 3
                                      ? cubit.allBuildingTasksModel!.data!
                                          .data![index].title!
                                      : selectedIndex == 4
                                          ? cubit.allFloorTasksModel!.data!
                                              .data![index].title!
                                          : selectedIndex == 5
                                              ? cubit.allSectionTasksModel!
                                                  .data!.data![index].title!
                                              : cubit.allPointTasksModel!.data!
                                                  .data![index].title!,
                      style: TextStyles.font16BlackSemiBold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
              Text(
                selectedIndex == 0
                    ? cubit.allAreaTasksModel!.data!.data![index].description!
                    : selectedIndex == 1
                        ? cubit
                            .allCityTasksModel!.data!.data![index].description!
                        : selectedIndex == 2
                            ? cubit.allOrganizationTasksModel!.data!
                                .data![index].description!
                            : selectedIndex == 3
                                ? cubit.allBuildingTasksModel!.data!
                                    .data![index].description!
                                : selectedIndex == 4
                                    ? cubit.allFloorTasksModel!.data!
                                        .data![index].description!
                                    : selectedIndex == 5
                                        ? cubit.allSectionTasksModel!.data!
                                            .data![index].description!
                                        : cubit.allPointTasksModel!.data!
                                            .data![index].description!,
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
                          text: selectedIndex == 0
                              ? formatTime(cubit.allAreaTasksModel!.data!
                                  .data![index].startTime!)
                              : selectedIndex == 1
                                  ? formatTime(cubit.allCityTasksModel!.data!
                                      .data![index].startTime!)
                                  : selectedIndex == 2
                                      ? formatTime(cubit
                                          .allOrganizationTasksModel!
                                          .data!
                                          .data![index]
                                          .startTime!)
                                      : selectedIndex == 3
                                          ? formatTime(cubit
                                              .allBuildingTasksModel!
                                              .data!
                                              .data![index]
                                              .startTime!)
                                          : selectedIndex == 4
                                              ? formatTime(cubit
                                                  .allFloorTasksModel!
                                                  .data!
                                                  .data![index]
                                                  .startTime!)
                                              : selectedIndex == 5
                                                  ? formatTime(cubit
                                                      .allSectionTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .startTime!)
                                                  : formatTime(cubit
                                                      .allPointTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .startTime!),
                          style: TextStyles.font11PrimMedium,
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyles.font11BlackMedium,
                        ),
                        TextSpan(
                          text: selectedIndex == 0
                              ? cubit.allAreaTasksModel!.data!.data![index]
                                  .startDate!
                              : selectedIndex == 1
                                  ? cubit.allCityTasksModel!.data!.data![index]
                                      .startDate!
                                  : selectedIndex == 2
                                      ? cubit.allOrganizationTasksModel!.data!
                                          .data![index].startDate!
                                      : selectedIndex == 3
                                          ? cubit.allBuildingTasksModel!.data!
                                              .data![index].startDate!
                                          : selectedIndex == 4
                                              ? cubit.allFloorTasksModel!.data!
                                                  .data![index].startDate!
                                              : selectedIndex == 5
                                                  ? cubit
                                                      .allSectionTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .startDate!
                                                  : cubit
                                                      .allPointTasksModel!
                                                      .data!
                                                      .data![index]
                                                      .startDate!,
                          style: TextStyles.font11PrimMedium,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Builder(builder: (_) {
                    final users = selectedIndex == 0
                        ? cubit.allAreaTasksModel!.data!.data![index].users ??
                            []
                        : selectedIndex == 1
                            ? cubit.allCityTasksModel!.data!.data![index]
                                    .users ??
                                []
                            : selectedIndex == 2
                                ? cubit.allOrganizationTasksModel!.data!
                                        .data![index].users ??
                                    []
                                : selectedIndex == 3
                                    ? cubit.allBuildingTasksModel!.data!
                                            .data![index].users ??
                                        []
                                    : selectedIndex == 4
                                        ? cubit.allFloorTasksModel!.data!
                                                .data![index].users ??
                                            []
                                        : selectedIndex == 5
                                            ? cubit.allSectionTasksModel!.data!
                                                    .data![index].users ??
                                                []
                                            : cubit.allPointTasksModel!.data!
                                                    .data![index].users ??
                                                [];
                    final visibleUsers = users.take(2).toList();
                    final extraCount = users.length > 2 ? users.length - 2 : 0;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (extraCount > 0)
                          Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              '+$extraCount',
                              style: TextStyle(
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
                              return Positioned(
                                left: i * 20.0,
                                child: Container(
                                  width: 30.r,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.w),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      visibleUsers[i].image ?? '',
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
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
