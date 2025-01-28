import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';

Widget buildCardItem(BuildContext context, index) {
  final List<String> status = ["Absent", "Late", "Present"];
  final List<Color> statusColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  String historystatus;
  Color statusColorForTask;

  //   // historystatus = context
  //   //     .read<TaskManagementCubit>()
  //   //     .allhistoryModel!
  //   //     .data!
  //   //     .data![index]
  //   //     .status!;

  // // Find the color based on the priority value
  // if (status.contains(historystatus)) {
  //   statusColorForTask = statusColor[status.indexOf(historystatus)];
  // } else {
  //   statusColorForTask = Colors.black;
  // }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: () {
        context.pushNamed(Routes.taskDetailsScreen,
            arguments: context
                .read<TaskManagementCubit>()
                .allTasksModel!
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
                  // Container(
                  //   height: 23.h,
                  //   margin: EdgeInsets.zero,
                  //   padding: EdgeInsets.symmetric(horizontal: 5),
                  //   decoration: BoxDecoration(
                  //     color: statusColorForTask.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(4.r),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       context
                  //           .read<TaskManagementCubit>()
                  //           .allTasksModel!
                  //           .data!
                  //           .data![index]
                  //           .priority!,
                  //       style: TextStyles.font11WhiteSemiBold.copyWith(
                  //         color: statusColorForTask,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  horizontalSpace(5),
                  Container(
                    height: 23.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffA8ADA7),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        context
                            .read<TaskManagementCubit>()
                            .allTasksModel!
                            .data!
                            .data![index]
                            .status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 23.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffA8ADA7),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        context
                            .read<TaskManagementCubit>()
                            .allTasksModel!
                            .data!
                            .data![index]
                            .status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                context
                    .read<TaskManagementCubit>()
                    .allTasksModel!
                    .data!
                    .data![index]
                    .title!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                context
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
                    IconBroken.calendar,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                  horizontalSpace(5),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context
                              .read<TaskManagementCubit>()
                              .allTasksModel!
                              .data!
                              .data![index]
                              .startTime!,
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        TextSpan(
                          text: '  :  ',
                          style: TextStyles.font14GreyRegular,
                        ),
                        TextSpan(
                          text: context
                              .read<TaskManagementCubit>()
                              .allTasksModel!
                              .data!
                              .data![index]
                              .endTime!,
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      border: Border.all(color: Colors.white, width: 1.w),
                    ),
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
