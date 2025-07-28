import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_details/logic/cubit/sensor_details_cubit.dart';

class TaskItemBuild extends StatelessWidget {
  final int id;
  final int index;
  const TaskItemBuild({super.key, required this.index, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorDetailsCubit>();
    final String taskPriority =
        cubit.allTasksModel!.data!.data![index].priority!;
    final task = cubit.allTasksModel!.data!.data![index];
    final hasUsers = task.users != null && task.users!.isNotEmpty;
    final userImage = hasUsers ? task.users!.first.image : null;
    final Color priorityColorForTask = cubit.getPriorityColor(taskPriority);
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(Routes.taskDetailsScreen,
            arguments: cubit.allTasksModel!.data!.data![index].id!);

        if (result == true) {
          cubit.refreshTasks(id);
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
                        cubit.allTasksModel!.data!.data![index].status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              verticalSpace(10),
              Text(
                cubit.allTasksModel!.data!.data![index].title!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                cubit.allTasksModel!.data!.data![index].description!,
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
                    cubit.formatTime(
                        cubit.allTasksModel?.data?.data?[index].startTime),
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.primaryColor),
                  ),
                  Spacer(),
                  Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.w),
                    ),
                    child: ClipOval(
                      child: userImage != null
                          ? Image.network(
                              userImage,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/person.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset(
                              'assets/images/person.png',
                              fit: BoxFit.fill,
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
