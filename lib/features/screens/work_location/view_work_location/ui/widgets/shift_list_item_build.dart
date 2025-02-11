import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget listShiftItemBuild(BuildContext context, index, selectedIndex) {
  return InkWell(borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(Routes.shiftDetailsScreen,
          arguments: selectedIndex == 2
              ? context
                  .read<WorkLocationCubit>()
                  .organizationShiftsDetailsModel!
                  .data!
                  .shifts![index]
                  .id
              : selectedIndex == 3
                  ? context
                      .read<WorkLocationCubit>()
                      .buildingShiftsDetailsModel!
                      .data!
                      .shifts![index]
                      .id
                  : selectedIndex == 4
                      ? context
                          .read<WorkLocationCubit>()
                          .floorShiftsDetailsModel!
                          .data!
                          .shifts![index]
                          .id
                      : context
                          .read<WorkLocationCubit>()
                          .pointShiftsDetailsModel!
                          .data!
                          .shifts![index]
                          .id);
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
                  selectedIndex == 2
                      ? context
                          .read<WorkLocationCubit>()
                          .organizationShiftsDetailsModel!
                          .data!
                          .shifts![index]
                          .name!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationCubit>()
                              .buildingShiftsDetailsModel!
                              .data!
                              .shifts![index]
                              .name!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationCubit>()
                                  .floorShiftsDetailsModel!
                                  .data!
                                  .shifts![index]
                                  .name!
                              : context
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
                        text: selectedIndex == 2
                            ? context
                                .read<WorkLocationCubit>()
                                .organizationShiftsDetailsModel!
                                .data!
                                .shifts![index]
                                .startTime!
                            : selectedIndex == 3
                                ? context
                                    .read<WorkLocationCubit>()
                                    .buildingShiftsDetailsModel!
                                    .data!
                                    .shifts![index]
                                    .startTime!
                                : selectedIndex == 4
                                    ? context
                                        .read<WorkLocationCubit>()
                                        .floorShiftsDetailsModel!
                                        .data!
                                        .shifts![index]
                                        .startTime!
                                    : context
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
                        text: selectedIndex == 2
                            ? context
                                .read<WorkLocationCubit>()
                                .organizationShiftsDetailsModel!
                                .data!
                                .shifts![index]
                                .endTime!
                            : selectedIndex == 3
                                ? context
                                    .read<WorkLocationCubit>()
                                    .buildingShiftsDetailsModel!
                                    .data!
                                    .shifts![index]
                                    .endTime!
                                : selectedIndex == 4
                                    ? context
                                        .read<WorkLocationCubit>()
                                        .floorShiftsDetailsModel!
                                        .data!
                                        .shifts![index]
                                        .endTime!
                                    : context
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
                  selectedIndex == 2
                      ? context
                          .read<WorkLocationCubit>()
                          .organizationShiftsDetailsModel!
                          .data!
                          .shifts![index]
                          .startDate!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationCubit>()
                              .buildingShiftsDetailsModel!
                              .data!
                              .shifts![index]
                              .startDate!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationCubit>()
                                  .floorShiftsDetailsModel!
                                  .data!
                                  .shifts![index]
                                  .startDate!
                              : context
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
                  selectedIndex == 2
                      ? context
                          .read<WorkLocationCubit>()
                          .organizationShiftsDetailsModel!
                          .data!
                          .shifts![index]
                          .endDate!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationCubit>()
                              .buildingShiftsDetailsModel!
                              .data!
                              .shifts![index]
                              .endDate!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationCubit>()
                                  .floorShiftsDetailsModel!
                                  .data!
                                  .shifts![index]
                                  .endDate!
                              : context
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
