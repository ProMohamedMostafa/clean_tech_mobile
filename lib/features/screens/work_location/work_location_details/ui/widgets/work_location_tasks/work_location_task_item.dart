import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationTaskItem extends StatelessWidget {
  final int selectedIndex;
  final int index;
  const WorkLocationTaskItem(
      {super.key, required this.selectedIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();

    final List<String> priority = [S.of(context).high, S.of(context).medium, S.of(context).low];
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
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        context.pushNamed(Routes.taskDetailsScreen,
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
              Text(
                selectedIndex == 0
                    ? cubit.allAreaTasksModel!.data!.data![index].title!
                    : selectedIndex == 1
                        ? cubit.allCityTasksModel!.data!.data![index].title!
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
                                        ? cubit.allSectionTasksModel!.data!
                                            .data![index].title!
                                        : cubit.allPointTasksModel!.data!
                                            .data![index].title!,
                style: TextStyles.font16BlackSemiBold,
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
                  Text(
                    selectedIndex == 0
                        ? cubit.allAreaTasksModel!.data!.data![index].startTime!
                        : selectedIndex == 1
                            ? cubit.allCityTasksModel!.data!.data![index]
                                .startTime!
                            : selectedIndex == 2
                                ? cubit.allOrganizationTasksModel!.data!
                                    .data![index].startTime!
                                : selectedIndex == 3
                                    ? cubit.allBuildingTasksModel!.data!
                                        .data![index].startTime!
                                    : selectedIndex == 4
                                        ? cubit.allFloorTasksModel!.data!
                                            .data![index].startTime!
                                        : selectedIndex == 5
                                            ? cubit.allSectionTasksModel!.data!
                                                .data![index].startTime!
                                            : cubit.allPointTasksModel!.data!
                                                .data![index].startTime!,
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
}
