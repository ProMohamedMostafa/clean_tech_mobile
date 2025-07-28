import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/logic/profile_cubit.dart';

class TaskCardItem extends StatelessWidget {
  final int index;
  const TaskCardItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(Routes.taskDetailsScreen,
            arguments: cubit.userTaskDetailsModel!.data!.data![index].id!);

        if (result == true) {
          cubit.getUserTaskDetails();
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
                      color: cubit
                          .getPriorityColor(cubit.userTaskDetailsModel!.data!
                              .data![index].priority!)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        cubit
                            .userTaskDetailsModel!.data!.data![index].priority!,
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
                        cubit.userTaskDetailsModel!.data!.data![index].status!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(5),
              Text(
                cubit.userTaskDetailsModel!.data!.data![index].title!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                cubit.userTaskDetailsModel!.data!.data![index].description!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyles.font11GreyMedium,
              ),
              verticalSpace(10),
              Row(
                children: [
                  Icon(
                    IconBroken.timeCircle,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                  horizontalSpace(5),
                  Text(
                    cubit.userTaskDetailsModel!.data!.data![index].startTime!,
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.primaryColor),
                  ),
                  const Spacer(),

                 
                  Builder(builder: (_) {
                    final users =
                        cubit.userTaskDetailsModel!.data!.data![index].users ??
                            [];
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
