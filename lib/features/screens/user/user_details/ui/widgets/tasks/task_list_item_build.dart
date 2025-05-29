import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';

class TaskCardItem extends StatelessWidget {
  final int index;
  const TaskCardItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        context.pushNamed(Routes.taskDetailsScreen,
            arguments: context
                .read<UserDetailsCubit>()
                .userTaskDetailsModel!
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
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
                      color: cubit
                          .getPriorityColor(cubit.userTaskDetailsModel!.data!
                              .data![index].priority!)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        context
                            .read<UserDetailsCubit>()
                            .userTaskDetailsModel!
                            .data!
                            .data![index]
                            .priority!,
                        style: TextStyles.font11WhiteSemiBold.copyWith(
                          color: cubit.getPriorityColor(cubit
                              .userTaskDetailsModel!
                              .data!
                              .data![index]
                              .priority!),
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
                        context
                            .read<UserDetailsCubit>()
                            .userTaskDetailsModel!
                            .data!
                            .data![index]
                            .status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      PopUpDialog.show(
                          context: context,
                          id: context
                              .read<UserDetailsCubit>()
                              .userTaskDetailsModel!
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
                context
                    .read<UserDetailsCubit>()
                    .userTaskDetailsModel!
                    .data!
                    .data![index]
                    .title!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                context
                    .read<UserDetailsCubit>()
                    .userTaskDetailsModel!
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
                    context
                        .read<UserDetailsCubit>()
                        .userTaskDetailsModel!
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
}
