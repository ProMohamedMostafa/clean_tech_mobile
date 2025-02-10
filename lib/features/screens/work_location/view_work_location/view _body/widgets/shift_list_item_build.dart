import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget listShiftItemBuild(BuildContext context, index) {
  return InkWell(
    onTap: () {
      // context.pushNamed(Routes.shiftDetailsScreen,
      //     arguments: context
      //         .read<WorkLocationCubit>()
      //         .pointShiftsDetailsModel!
      //         .data!
      //         .shifts![index]
      //         .id);
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 125.h,
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
                Text(
                  context
                      .read<WorkLocationCubit>()
                      .pointShiftsDetailsModel!
                      .data!
                      .shifts![index]
                      .name!,
                  style: TextStyles.font16BlackSemiBold,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // PopUpDialog.show(
                    //     context: context,
                    //     id: context
                    //         .read<WorkLocationCubit>()
                    //         .userTaskDetailsModel!
                    //         .data!
                    //         .data![index]
                    //         .id!);
                  },
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    size: 22.sp,
                  ),
                )
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Icon(
                  IconBroken.timeCircle,
                  color: AppColor.thirdColor,
                  size: 18.sp,
                ),
                horizontalSpace(5),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context
                            .read<WorkLocationCubit>()
                            .pointShiftsDetailsModel!
                            .data!
                            .shifts![index]
                            .startTime!,
                        style: TextStyles.font12GreyRegular,
                      ),
                      TextSpan(
                        text: '  -  ',
                        style: TextStyles.font12GreyRegular,
                      ),
                      TextSpan(
                        text: context
                            .read<WorkLocationCubit>()
                            .pointShiftsDetailsModel!
                            .data!
                            .shifts![index]
                            .endTime!,
                        style: TextStyles.font12GreyRegular,
                      ),
                    ],
                  ),
                ),
              ],
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
                Text(
                  context
                      .read<WorkLocationCubit>()
                      .pointShiftsDetailsModel!
                      .data!
                      .shifts![index]
                      .startDate!,
                  style: TextStyles.font11WhiteSemiBold
                      .copyWith(color: AppColor.primaryColor),
                ),
                Spacer(),
                Icon(
                  IconBroken.calendar,
                  color: AppColor.primaryColor,
                  size: 22.sp,
                ),
                horizontalSpace(5),
                Text(
                  context
                      .read<WorkLocationCubit>()
                      .pointShiftsDetailsModel!
                      .data!
                      .shifts![index]
                      .endDate!,
                  style: TextStyles.font11WhiteSemiBold
                      .copyWith(color: AppColor.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
