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

Widget buildLeavesCardItem(BuildContext context, index, selectedIndex) {
  return InkWell(borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(Routes.leavesDetailsScreen,
          arguments: selectedIndex == 0
              ? context
                  .read<WorkLocationCubit>()
                  .attendanceLeavesAreaModel!
                  .data!
                  .leaves![index]
                  .id!
              : selectedIndex == 1
                  ? context
                      .read<WorkLocationCubit>()
                      .attendanceLeavesCityModel!
                      .data!
                      .leaves![index]
                      .id!
                  : selectedIndex == 2
                      ? context
                          .read<WorkLocationCubit>()
                          .attendanceLeavesOrganizationModel!
                          .data!
                          .leaves![index]
                          .id!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationCubit>()
                              .attendanceLeavesBuildingModel!
                              .data!
                              .leaves![index]
                              .id!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesFloorModel!
                                  .data!
                                  .leaves![index]
                                  .id!
                              : context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesPointModel!
                                  .data!
                                  .leaves![index]
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
                    color: Color(0xffF6DCDF),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? context
                              .read<WorkLocationCubit>()
                              .attendanceLeavesAreaModel!
                              .data!
                              .leaves![index]
                              .type!
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesCityModel!
                                  .data!
                                  .leaves![index]
                                  .type!
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesOrganizationModel!
                                      .data!
                                      .leaves![index]
                                      .type!
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .attendanceLeavesBuildingModel!
                                          .data!
                                          .leaves![index]
                                          .type!
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .attendanceLeavesFloorModel!
                                              .data!
                                              .leaves![index]
                                              .type!
                                          : context
                                              .read<WorkLocationCubit>()
                                              .attendanceLeavesPointModel!
                                              .data!
                                              .leaves![index]
                                              .type!,
                      style: TextStyles.font11WhiteSemiBold.copyWith(
                        color: Color(0xffD25260),
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? context
                              .read<WorkLocationCubit>()
                              .attendanceLeavesAreaModel!
                              .data!
                              .leaves![index]
                              .role!
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesCityModel!
                                  .data!
                                  .leaves![index]
                                  .role!
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesOrganizationModel!
                                      .data!
                                      .leaves![index]
                                      .role!
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .attendanceLeavesBuildingModel!
                                          .data!
                                          .leaves![index]
                                          .role!
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .attendanceLeavesFloorModel!
                                              .data!
                                              .leaves![index]
                                              .role!
                                          : context
                                              .read<WorkLocationCubit>()
                                              .attendanceLeavesPointModel!
                                              .data!
                                              .leaves![index]
                                              .role!,
                      style: TextStyles.font11WhiteSemiBold
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // PopUpDialog.show(
                    //   context: context,
                    //   id: context
                    //       .read<WorkLocationCubit>()
                    //       .attendanceLeavesPointModel!
                    //       .data!
                    //       .data![index]
                    //       .id!,
                    // );
                  },
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
            Text(
              selectedIndex == 0
                  ? context
                      .read<WorkLocationCubit>()
                      .attendanceLeavesAreaModel!
                      .data!
                      .leaves![index]
                      .userName!
                  : selectedIndex == 1
                      ? context
                          .read<WorkLocationCubit>()
                          .attendanceLeavesCityModel!
                          .data!
                          .leaves![index]
                          .userName!
                      : selectedIndex == 2
                          ? context
                              .read<WorkLocationCubit>()
                              .attendanceLeavesOrganizationModel!
                              .data!
                              .leaves![index]
                              .userName!
                          : selectedIndex == 3
                              ? context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesBuildingModel!
                                  .data!
                                  .leaves![index]
                                  .userName!
                              : selectedIndex == 4
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesFloorModel!
                                      .data!
                                      .leaves![index]
                                      .userName!
                                  : context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesPointModel!
                                      .data!
                                      .leaves![index]
                                      .userName!,
              style: TextStyles.font16BlackSemiBold,
            ),
            verticalSpace(10),
            Text(
              selectedIndex == 0
                  ? context
                      .read<WorkLocationCubit>()
                      .attendanceLeavesAreaModel!
                      .data!
                      .leaves![index]
                      .reason!
                  : selectedIndex == 1
                      ? context
                          .read<WorkLocationCubit>()
                          .attendanceLeavesCityModel!
                          .data!
                          .leaves![index]
                          .reason!
                      : selectedIndex == 2
                          ? context
                              .read<WorkLocationCubit>()
                              .attendanceLeavesOrganizationModel!
                              .data!
                              .leaves![index]
                              .reason!
                          : selectedIndex == 3
                              ? context
                                  .read<WorkLocationCubit>()
                                  .attendanceLeavesBuildingModel!
                                  .data!
                                  .leaves![index]
                                  .reason!
                              : selectedIndex == 4
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesFloorModel!
                                      .data!
                                      .leaves![index]
                                      .reason!
                                  : context
                                      .read<WorkLocationCubit>()
                                      .attendanceLeavesPointModel!
                                      .data!
                                      .leaves![index]
                                      .reason!,
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
                        text: selectedIndex == 0
                            ? context
                                    .read<WorkLocationCubit>()
                                    .attendanceLeavesAreaModel!
                                    .data!
                                    .leaves![index]
                                    .startDate ??
                                ''
                            : selectedIndex == 1
                                ? context
                                        .read<WorkLocationCubit>()
                                        .attendanceLeavesCityModel!
                                        .data!
                                        .leaves![index]
                                        .startDate ??
                                    ''
                                : selectedIndex == 2
                                    ? context
                                            .read<WorkLocationCubit>()
                                            .attendanceLeavesOrganizationModel!
                                            .data!
                                            .leaves![index]
                                            .startDate ??
                                        ''
                                    : selectedIndex == 3
                                        ? context
                                                .read<WorkLocationCubit>()
                                                .attendanceLeavesBuildingModel!
                                                .data!
                                                .leaves![index]
                                                .startDate ??
                                            ''
                                        : selectedIndex == 4
                                            ? context
                                                    .read<WorkLocationCubit>()
                                                    .attendanceLeavesFloorModel!
                                                    .data!
                                                    .leaves![index]
                                                    .startDate ??
                                                ''
                                            : context
                                                    .read<WorkLocationCubit>()
                                                    .attendanceLeavesPointModel!
                                                    .data!
                                                    .leaves![index]
                                                    .startDate ??
                                                '',
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: '  :  ',
                        style: TextStyles.font14GreyRegular,
                      ),
                      TextSpan(
                        text: selectedIndex == 0
                            ? context
                                    .read<WorkLocationCubit>()
                                    .attendanceLeavesAreaModel!
                                    .data!
                                    .leaves![index]
                                    .endDate ??
                                ''
                            : selectedIndex == 1
                                ? context
                                        .read<WorkLocationCubit>()
                                        .attendanceLeavesCityModel!
                                        .data!
                                        .leaves![index]
                                        .endDate ??
                                    ''
                                : selectedIndex == 2
                                    ? context
                                            .read<WorkLocationCubit>()
                                            .attendanceLeavesOrganizationModel!
                                            .data!
                                            .leaves![index]
                                            .endDate ??
                                        ''
                                    : selectedIndex == 3
                                        ? context
                                                .read<WorkLocationCubit>()
                                                .attendanceLeavesBuildingModel!
                                                .data!
                                                .leaves![index]
                                                .endDate ??
                                            ''
                                        : selectedIndex == 4
                                            ? context
                                                    .read<WorkLocationCubit>()
                                                    .attendanceLeavesFloorModel!
                                                    .data!
                                                    .leaves![index]
                                                    .endDate ??
                                                ''
                                            : context
                                                    .read<WorkLocationCubit>()
                                                    .attendanceLeavesPointModel!
                                                    .data!
                                                    .leaves![index]
                                                    .endDate ??
                                                '',
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
