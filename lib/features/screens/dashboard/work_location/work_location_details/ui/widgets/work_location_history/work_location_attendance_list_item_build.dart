import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationAttendanceListItemBuild extends StatelessWidget {
  final int selectedIndex;
  final int index;
  const WorkLocationAttendanceListItemBuild(
      {super.key, required this.index, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 145.h,
        ),
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
                        .getStatusColor(selectedIndex == 0
                            ? cubit.attendanceHistoryAreaModel!.data!
                                .data![index].status!
                            : selectedIndex == 1
                                ? cubit.attendanceHistoryCityModel!.data!
                                    .data![index].status!
                                : selectedIndex == 2
                                    ? cubit.attendanceHistoryOrganizationModel!
                                        .data!.data![index].status!
                                    : selectedIndex == 3
                                        ? cubit.attendanceHistoryBuildingModel!
                                            .data!.data![index].status!
                                        : selectedIndex == 4
                                            ? cubit.attendanceHistoryFloorModel!
                                                .data!.data![index].status!
                                            : selectedIndex == 5
                                                ? cubit
                                                    .attendanceHistorySectionModel!
                                                    .data!
                                                    .data![index]
                                                    .status!
                                                : cubit
                                                    .attendanceHistoryPointModel!
                                                    .data!
                                                    .data![index]
                                                    .status!)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? cubit.attendanceHistoryAreaModel!.data!.data![index]
                              .status!
                          : selectedIndex == 1
                              ? cubit.attendanceHistoryCityModel!.data!
                                  .data![index].status!
                              : selectedIndex == 2
                                  ? cubit.attendanceHistoryOrganizationModel!
                                      .data!.data![index].status!
                                  : selectedIndex == 3
                                      ? cubit.attendanceHistoryBuildingModel!
                                          .data!.data![index].status!
                                      : selectedIndex == 4
                                          ? cubit.attendanceHistoryFloorModel!
                                              .data!.data![index].status!
                                          : selectedIndex == 5
                                              ? cubit
                                                  .attendanceHistorySectionModel!
                                                  .data!
                                                  .data![index]
                                                  .status!
                                              : cubit
                                                  .attendanceHistoryPointModel!
                                                  .data!
                                                  .data![index]
                                                  .status!,
                      style: TextStyles.font11WhiteSemiBold.copyWith(
                        color: cubit.getStatusColor(selectedIndex == 0
                            ? cubit.attendanceHistoryAreaModel!.data!
                                .data![index].status!
                            : selectedIndex == 1
                                ? cubit.attendanceHistoryCityModel!.data!
                                    .data![index].status!
                                : selectedIndex == 2
                                    ? cubit.attendanceHistoryOrganizationModel!
                                        .data!.data![index].status!
                                    : selectedIndex == 3
                                        ? cubit.attendanceHistoryBuildingModel!
                                            .data!.data![index].status!
                                        : selectedIndex == 4
                                            ? cubit.attendanceHistoryFloorModel!
                                                .data!.data![index].status!
                                            : selectedIndex == 5
                                                ? cubit
                                                    .attendanceHistorySectionModel!
                                                    .data!
                                                    .data![index]
                                                    .status!
                                                : cubit
                                                    .attendanceHistoryPointModel!
                                                    .data!
                                                    .data![index]
                                                    .status!),
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
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('d MMM').format(
                        DateTime.parse(
                          selectedIndex == 0
                              ? cubit.attendanceHistoryAreaModel!.data!
                                  .data![index].date!
                              : selectedIndex == 1
                                  ? cubit.attendanceHistoryCityModel!.data!
                                      .data![index].date!
                                  : selectedIndex == 2
                                      ? cubit
                                          .attendanceHistoryOrganizationModel!
                                          .data!
                                          .data![index]
                                          .date!
                                      : selectedIndex == 3
                                          ? cubit
                                              .attendanceHistoryBuildingModel!
                                              .data!
                                              .data![index]
                                              .date!
                                          : selectedIndex == 4
                                              ? cubit
                                                  .attendanceHistoryFloorModel!
                                                  .data!
                                                  .data![index]
                                                  .date!
                                              : selectedIndex == 5
                                                  ? cubit
                                                      .attendanceHistorySectionModel!
                                                      .data!
                                                      .data![index]
                                                      .date!
                                                  : cubit
                                                      .attendanceHistoryPointModel!
                                                      .data!
                                                      .data![index]
                                                      .date!,
                        ),
                      ),
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
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? cubit.attendanceHistoryAreaModel!.data!.data![index]
                              .role!
                          : selectedIndex == 1
                              ? cubit.attendanceHistoryCityModel!.data!
                                  .data![index].role!
                              : selectedIndex == 2
                                  ? cubit.attendanceHistoryOrganizationModel!
                                      .data!.data![index].role!
                                  : selectedIndex == 3
                                      ? cubit.attendanceHistoryBuildingModel!
                                          .data!.data![index].role!
                                      : selectedIndex == 4
                                          ? cubit.attendanceHistoryFloorModel!
                                              .data!.data![index].role!
                                          : selectedIndex == 5
                                              ? cubit
                                                  .attendanceHistorySectionModel!
                                                  .data!
                                                  .data![index]
                                                  .role!
                                              : cubit
                                                  .attendanceHistoryPointModel!
                                                  .data!
                                                  .data![index]
                                                  .role!,
                      style: TextStyles.font11WhiteSemiBold
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(15),
            Text(
              "${selectedIndex == 0 ? cubit.attendanceHistoryAreaModel!.data!.data![index].firstName! : selectedIndex == 1 ? cubit.attendanceHistoryCityModel!.data!.data![index].firstName! : selectedIndex == 2 ? cubit.attendanceHistoryOrganizationModel!.data!.data![index].firstName! : selectedIndex == 3 ? cubit.attendanceHistoryBuildingModel!.data!.data![index].firstName! : selectedIndex == 4 ? cubit.attendanceHistoryFloorModel!.data!.data![index].firstName! : selectedIndex == 5 ? cubit.attendanceHistorySectionModel!.data!.data![index].firstName! : cubit.attendanceHistoryPointModel!.data!.data![index].firstName!} ${selectedIndex == 0 ? cubit.attendanceHistoryAreaModel!.data!.data![index].lastName! : selectedIndex == 1 ? cubit.attendanceHistoryCityModel!.data!.data![index].lastName! : selectedIndex == 2 ? cubit.attendanceHistoryOrganizationModel!.data!.data![index].lastName! : selectedIndex == 3 ? cubit.attendanceHistoryBuildingModel!.data!.data![index].lastName! : selectedIndex == 4 ? cubit.attendanceHistoryFloorModel!.data!.data![index].lastName! : selectedIndex == 5 ? cubit.attendanceHistorySectionModel!.data!.data![index].lastName! : cubit.attendanceHistoryPointModel!.data!.data![index].lastName!}",
              style: TextStyles.font16BlackSemiBold,
            ),
            verticalSpace(5),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).shift,
                    style: TextStyles.font12GreyRegular,
                  ),
                  TextSpan(
                    text: selectedIndex == 0
                        ? cubit.attendanceHistoryAreaModel!.data!.data![index]
                            .startShift
                            ?.toString()
                        : selectedIndex == 1
                            ? cubit.attendanceHistoryCityModel!.data!
                                .data![index].startShift
                                ?.toString()
                            : selectedIndex == 2
                                ? cubit.attendanceHistoryOrganizationModel!
                                    .data!.data![index].startShift
                                    ?.toString()
                                : selectedIndex == 3
                                    ? cubit.attendanceHistoryBuildingModel!
                                        .data!.data![index].startShift
                                        ?.toString()
                                    : selectedIndex == 4
                                        ? cubit.attendanceHistoryFloorModel!
                                            .data!.data![index].startShift
                                            ?.toString()
                                        : selectedIndex == 5
                                            ? cubit
                                                .attendanceHistorySectionModel!
                                                .data!
                                                .data![index]
                                                .startShift
                                                ?.toString()
                                            : cubit
                                                        .attendanceHistoryPointModel!
                                                        .data!
                                                        .data![index]
                                                        .startShift
                                                        ?.toString() !=
                                                    null
                                                ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(selectedIndex == 0
                                                    ? cubit.attendanceHistoryAreaModel!.data!.data![index].startShift!.toString()
                                                    : selectedIndex == 1
                                                        ? cubit.attendanceHistoryCityModel!.data!.data![index].startShift!.toString()
                                                        : selectedIndex == 2
                                                            ? cubit.attendanceHistoryOrganizationModel!.data!.data![index].startShift!.toString()
                                                            : selectedIndex == 3
                                                                ? cubit.attendanceHistoryBuildingModel!.data!.data![index].startShift!.toString()
                                                                : selectedIndex == 4
                                                                    ? cubit.attendanceHistoryFloorModel!.data!.data![index].startShift!.toString()
                                                                    : selectedIndex == 5
                                                                        ? cubit.attendanceHistorySectionModel!.data!.data![index].startShift!.toString()
                                                                        : cubit.attendanceHistoryPointModel!.data!.data![index].startShift!.toString()))
                                                : '--',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                  TextSpan(
                    text: '  -  ',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                  TextSpan(
                    text: selectedIndex == 0
                        ? cubit.attendanceHistoryAreaModel!.data!.data![index]
                            .endShift
                            ?.toString()
                        : selectedIndex == 1
                            ? cubit.attendanceHistoryCityModel!.data!
                                .data![index].endShift
                                ?.toString()
                            : selectedIndex == 2
                                ? cubit.attendanceHistoryOrganizationModel!
                                    .data!.data![index].endShift
                                    ?.toString()
                                : selectedIndex == 3
                                    ? cubit.attendanceHistoryBuildingModel!
                                        .data!.data![index].endShift
                                        ?.toString()
                                    : selectedIndex == 4
                                        ? cubit.attendanceHistoryFloorModel!
                                            .data!.data![index].endShift
                                            ?.toString()
                                        : selectedIndex == 5
                                            ? cubit
                                                .attendanceHistorySectionModel!
                                                .data!
                                                .data![index]
                                                .endShift
                                                ?.toString()
                                            : cubit.attendanceHistoryPointModel!
                                                        .data!.data![index].endShift
                                                        ?.toString() !=
                                                    null
                                                ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(selectedIndex == 0
                                                    ? cubit.attendanceHistoryAreaModel!.data!.data![index].endShift!.toString()
                                                    : selectedIndex == 1
                                                        ? cubit.attendanceHistoryCityModel!.data!.data![index].endShift!.toString()
                                                        : selectedIndex == 2
                                                            ? cubit.attendanceHistoryOrganizationModel!.data!.data![index].endShift!.toString()
                                                            : selectedIndex == 3
                                                                ? cubit.attendanceHistoryBuildingModel!.data!.data![index].endShift!.toString()
                                                                : selectedIndex == 4
                                                                    ? cubit.attendanceHistoryFloorModel!.data!.data![index].endShift!.toString()
                                                                    : selectedIndex == 5
                                                                        ? cubit.attendanceHistorySectionModel!.data!.data![index].endShift!.toString()
                                                                        : cubit.attendanceHistoryPointModel!.data!.data![index].endShift!.toString()))
                                                : '--',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Row(
              children: [
                Icon(
                  IconBroken.timeCircle,
                  color: AppColor.primaryColor,
                  size: 18.sp,
                ),
                horizontalSpace(5),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      // Clock In
                      TextSpan(
                        text: DateFormat('HH:mm').format(
                          cubit.parseUtc(
                            selectedIndex == 0
                                ? cubit.attendanceHistoryAreaModel!.data!
                                    .data![index].clockIn!
                                : selectedIndex == 1
                                    ? cubit.attendanceHistoryCityModel!.data!
                                        .data![index].clockIn!
                                    : selectedIndex == 2
                                        ? cubit
                                            .attendanceHistoryOrganizationModel!
                                            .data!
                                            .data![index]
                                            .clockIn!
                                        : selectedIndex == 3
                                            ? cubit
                                                .attendanceHistoryBuildingModel!
                                                .data!
                                                .data![index]
                                                .clockIn!
                                            : selectedIndex == 4
                                                ? cubit
                                                    .attendanceHistoryFloorModel!
                                                    .data!
                                                    .data![index]
                                                    .clockIn!
                                                : selectedIndex == 5
                                                    ? cubit
                                                        .attendanceHistorySectionModel!
                                                        .data!
                                                        .data![index]
                                                        .clockIn!
                                                    : cubit
                                                        .attendanceHistoryPointModel!
                                                        .data!
                                                        .data![index]
                                                        .clockIn!,
                          ),
                        ),
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      // Separator
                      TextSpan(
                        text: '  -  ',
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      // Clock Out
                      TextSpan(
                        text: DateFormat('HH:mm').format(
                          cubit.parseUtc(
                            selectedIndex == 0
                                ? cubit.attendanceHistoryAreaModel!.data!
                                        .data![index].clockOut ??
                                    ''
                                : selectedIndex == 1
                                    ? cubit.attendanceHistoryCityModel!.data!
                                            .data![index].clockOut ??
                                        ''
                                    : selectedIndex == 2
                                        ? cubit.attendanceHistoryOrganizationModel!
                                                .data!.data![index].clockOut ??
                                            ''
                                        : selectedIndex == 3
                                            ? cubit
                                                    .attendanceHistoryBuildingModel!
                                                    .data!
                                                    .data![index]
                                                    .clockOut ??
                                                ''
                                            : selectedIndex == 4
                                                ? cubit
                                                        .attendanceHistoryFloorModel!
                                                        .data!
                                                        .data![index]
                                                        .clockOut ??
                                                    ''
                                                : selectedIndex == 5
                                                    ? cubit
                                                            .attendanceHistorySectionModel!
                                                            .data!
                                                            .data![index]
                                                            .clockOut ??
                                                        ''
                                                    : cubit
                                                            .attendanceHistoryPointModel!
                                                            .data!
                                                            .data![index]
                                                            .clockOut ??
                                                        '',
                          ),
                        ),
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: S.of(context).duration,
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: cubit.formatDuration(
                          selectedIndex == 0
                              ? cubit.attendanceHistoryAreaModel!.data!
                                      .data![index].duration ??
                                  ''
                              : selectedIndex == 1
                                  ? cubit.attendanceHistoryCityModel!.data!
                                          .data![index].duration ??
                                      ''
                                  : selectedIndex == 2
                                      ? cubit.attendanceHistoryOrganizationModel!
                                              .data!.data![index].duration ??
                                          ''
                                      : selectedIndex == 3
                                          ? cubit
                                                  .attendanceHistoryBuildingModel!
                                                  .data!
                                                  .data![index]
                                                  .duration ??
                                              ''
                                          : selectedIndex == 4
                                              ? cubit
                                                      .attendanceHistoryFloorModel!
                                                      .data!
                                                      .data![index]
                                                      .duration ??
                                                  ''
                                              : selectedIndex == 5
                                                  ? cubit
                                                          .attendanceHistorySectionModel!
                                                          .data!
                                                          .data![index]
                                                          .duration ??
                                                      ''
                                                  : cubit
                                                          .attendanceHistoryPointModel!
                                                          .data!
                                                          .data![index]
                                                          .duration ??
                                                      '',
                        ),
                        style: TextStyles.font12GreyRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
