import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/logic/cubit/work_location_details_cubit.dart';

Widget buildAttendanceCardItem(BuildContext context, index, selectedIndex) {
  String formatDuration(String? duration) {
    if (duration == null || duration.isEmpty) {
      return "    ";
    }

    final durationParts = duration.split(':');
    if (durationParts.length != 3) {
      return "Invalid Format";
    }

    try {
      final hours = int.tryParse(durationParts[0]) ?? 0;
      final minutes = int.tryParse(durationParts[1]) ?? 0;
      final seconds = double.tryParse(durationParts[2])?.floor() ?? 0;

      if (hours > 0) {
        return '$hours hr';
      } else if (minutes > 0) {
        return '$minutes min';
      } else {
        return '$seconds sec';
      }
    } catch (e) {
      return "Invalid Data";
    }
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return " ";
    try {
      DateTime parsedTime = DateTime.parse(time);
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return "Invalid Time";
    }
  }

  final List<String> status = ["Absent", "Late", "Present"];
  final List<Color> statusColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  String historystatus;
  Color statusColorForTask;

  historystatus = selectedIndex == 0
      ? context
          .read<WorkLocationDetailsCubit>()
          .attendanceHistoryAreaModel!
          .data!
          .data![index]
          .status!
      : selectedIndex == 1
          ? context
              .read<WorkLocationDetailsCubit>()
              .attendanceHistoryCityModel!
              .data!
              .data![index]
              .status!
          : selectedIndex == 2
              ? context
                  .read<WorkLocationDetailsCubit>()
                  .attendanceHistoryOrganizationModel!
                  .data!
                  .data![index]
                  .status!
              : selectedIndex == 3
                  ? context
                      .read<WorkLocationDetailsCubit>()
                      .attendanceHistoryBuildingModel!
                      .data!
                      .data![index]
                      .status!
                  : selectedIndex == 4
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .attendanceHistoryFloorModel!
                          .data!
                          .data![index]
                          .status!
                      : selectedIndex == 5
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .attendanceHistorySectionModel!
                              .data!
                              .data![index]
                              .status!
                          : context
                              .read<WorkLocationDetailsCubit>()
                              .attendanceHistoryPointModel!
                              .data!
                              .data![index]
                              .status!;

  if (status.contains(historystatus)) {
    statusColorForTask = statusColor[status.indexOf(historystatus)];
  } else {
    statusColorForTask = Colors.black;
  }
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
      padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
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
                  color: statusColorForTask.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: Text(
                    selectedIndex == 0
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .attendanceHistoryAreaModel!
                            .data!
                            .data![index]
                            .status!
                        : selectedIndex == 1
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceHistoryCityModel!
                                .data!
                                .data![index]
                                .status!
                            : selectedIndex == 2
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .attendanceHistoryOrganizationModel!
                                    .data!
                                    .data![index]
                                    .status!
                                : selectedIndex == 3
                                    ? context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistoryBuildingModel!
                                        .data!
                                        .data![index]
                                        .status!
                                    : selectedIndex == 4
                                        ? context
                                            .read<WorkLocationDetailsCubit>()
                                            .attendanceHistoryFloorModel!
                                            .data!
                                            .data![index]
                                            .status!
                                        : selectedIndex == 5
                                            ? context
                                                .read<WorkLocationDetailsCubit>()
                                                .attendanceHistorySectionModel!
                                                .data!
                                                .data![index]
                                                .status!
                                            : context
                                                .read<WorkLocationDetailsCubit>()
                                                .attendanceHistoryPointModel!
                                                .data!
                                                .data![index]
                                                .status!,
                    style: TextStyles.font11WhiteSemiBold.copyWith(
                      color: statusColorForTask,
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
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceHistoryAreaModel!
                                .data!
                                .data![index]
                                .date!
                            : selectedIndex == 1
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .attendanceHistoryCityModel!
                                    .data!
                                    .data![index]
                                    .date!
                                : selectedIndex == 2
                                    ? context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistoryOrganizationModel!
                                        .data!
                                        .data![index]
                                        .date!
                                    : selectedIndex == 3
                                        ? context
                                            .read<WorkLocationDetailsCubit>()
                                            .attendanceHistoryBuildingModel!
                                            .data!
                                            .data![index]
                                            .date!
                                        : selectedIndex == 4
                                            ? context
                                                .read<WorkLocationDetailsCubit>()
                                                .attendanceHistoryFloorModel!
                                                .data!
                                                .data![index]
                                                .date!
                                            : selectedIndex == 5
                                                ? context
                                                    .read<WorkLocationDetailsCubit>()
                                                    .attendanceHistorySectionModel!
                                                    .data!
                                                    .data![index]
                                                    .date!
                                                : context
                                                    .read<WorkLocationDetailsCubit>()
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
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .attendanceHistoryAreaModel!
                            .data!
                            .data![index]
                            .role!
                        : selectedIndex == 1
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceHistoryCityModel!
                                .data!
                                .data![index]
                                .role!
                            : selectedIndex == 2
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .attendanceHistoryOrganizationModel!
                                    .data!
                                    .data![index]
                                    .role!
                                : selectedIndex == 3
                                    ? context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistoryBuildingModel!
                                        .data!
                                        .data![index]
                                        .role!
                                    : selectedIndex == 4
                                        ? context
                                            .read<WorkLocationDetailsCubit>()
                                            .attendanceHistoryFloorModel!
                                            .data!
                                            .data![index]
                                            .role!
                                        : selectedIndex == 5
                                            ? context
                                                .read<WorkLocationDetailsCubit>()
                                                .attendanceHistorySectionModel!
                                                .data!
                                                .data![index]
                                                .role!
                                            : context
                                                .read<WorkLocationDetailsCubit>()
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
            selectedIndex == 0
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .attendanceHistoryAreaModel!
                    .data!
                    .data![index]
                    .userName!
                : selectedIndex == 1
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .attendanceHistoryCityModel!
                        .data!
                        .data![index]
                        .userName!
                    : selectedIndex == 2
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .attendanceHistoryOrganizationModel!
                            .data!
                            .data![index]
                            .userName!
                        : selectedIndex == 3
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceHistoryBuildingModel!
                                .data!
                                .data![index]
                                .userName!
                            : selectedIndex == 4
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .attendanceHistoryFloorModel!
                                    .data!
                                    .data![index]
                                    .userName!
                                : selectedIndex == 5
                                    ? context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistorySectionModel!
                                        .data!
                                        .data![index]
                                        .userName!
                                    : context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistoryPointModel!
                                        .data!
                                        .data![index]
                                        .userName!,
            style: TextStyles.font16BlackSemiBold,
          ),
          verticalSpace(5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Shift : ',
                  style: TextStyles.font12GreyRegular,
                ),
                TextSpan(
                  text: selectedIndex == 0
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .attendanceHistoryAreaModel!
                          .data!
                          .data![index]
                          .startShift
                          ?.toString()
                      : selectedIndex == 1
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .attendanceHistoryCityModel!
                              .data!
                              .data![index]
                              .startShift
                              ?.toString()
                          : selectedIndex == 2
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .attendanceHistoryOrganizationModel!
                                  .data!
                                  .data![index]
                                  .startShift
                                  ?.toString()
                              : selectedIndex == 3
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .attendanceHistoryBuildingModel!
                                      .data!
                                      .data![index]
                                      .startShift
                                      ?.toString()
                                  : selectedIndex == 4
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .attendanceHistoryFloorModel!
                                          .data!
                                          .data![index]
                                          .startShift
                                          ?.toString()
                                      : selectedIndex == 5
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .attendanceHistorySectionModel!
                                              .data!
                                              .data![index]
                                              .startShift
                                              ?.toString()
                                          : context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryPointModel!
                                                      .data!
                                                      .data![index]
                                                      .startShift
                                                      ?.toString() !=
                                                  null
                                              ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(selectedIndex ==
                                                      0
                                                  ? context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryAreaModel!
                                                      .data!
                                                      .data![index]
                                                      .startShift!
                                                      .toString()
                                                  : selectedIndex == 1
                                                      ? context
                                                          .read<
                                                              WorkLocationDetailsCubit>()
                                                          .attendanceHistoryCityModel!
                                                          .data!
                                                          .data![index]
                                                          .startShift!
                                                          .toString()
                                                      : selectedIndex == 2
                                                          ? context
                                                              .read<
                                                                  WorkLocationDetailsCubit>()
                                                              .attendanceHistoryOrganizationModel!
                                                              .data!
                                                              .data![index]
                                                              .startShift!
                                                              .toString()
                                                          : selectedIndex == 3
                                                              ? context
                                                                  .read<
                                                                      WorkLocationDetailsCubit>()
                                                                  .attendanceHistoryBuildingModel!
                                                                  .data!
                                                                  .data![index]
                                                                  .startShift!
                                                                  .toString()
                                                              : selectedIndex ==
                                                                      4
                                                                  ? context
                                                                      .read<
                                                                          WorkLocationDetailsCubit>()
                                                                      .attendanceHistoryFloorModel!
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .startShift!
                                                                      .toString()
                                                                  : selectedIndex ==
                                                                          5
                                                                      ? context
                                                                          .read<
                                                                              WorkLocationDetailsCubit>()
                                                                          .attendanceHistorySectionModel!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .startShift!
                                                                          .toString()
                                                                      : context
                                                                          .read<
                                                                              WorkLocationDetailsCubit>()
                                                                          .attendanceHistoryPointModel!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .startShift!
                                                                          .toString()))
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
                      ? context
                          .read<WorkLocationDetailsCubit>()
                          .attendanceHistoryAreaModel!
                          .data!
                          .data![index]
                          .endShift
                          ?.toString()
                      : selectedIndex == 1
                          ? context
                              .read<WorkLocationDetailsCubit>()
                              .attendanceHistoryCityModel!
                              .data!
                              .data![index]
                              .endShift
                              ?.toString()
                          : selectedIndex == 2
                              ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .attendanceHistoryOrganizationModel!
                                  .data!
                                  .data![index]
                                  .endShift
                                  ?.toString()
                              : selectedIndex == 3
                                  ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .attendanceHistoryBuildingModel!
                                      .data!
                                      .data![index]
                                      .endShift
                                      ?.toString()
                                  : selectedIndex == 4
                                      ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .attendanceHistoryFloorModel!
                                          .data!
                                          .data![index]
                                          .endShift
                                          ?.toString()
                                      : selectedIndex == 5
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .attendanceHistorySectionModel!
                                              .data!
                                              .data![index]
                                              .endShift
                                              ?.toString()
                                          : context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryPointModel!
                                                      .data!
                                                      .data![index]
                                                      .endShift
                                                      ?.toString() !=
                                                  null
                                              ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(selectedIndex ==
                                                      0
                                                  ? context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryAreaModel!
                                                      .data!
                                                      .data![index]
                                                      .endShift!
                                                      .toString()
                                                  : selectedIndex == 1
                                                      ? context
                                                          .read<
                                                              WorkLocationDetailsCubit>()
                                                          .attendanceHistoryCityModel!
                                                          .data!
                                                          .data![index]
                                                          .endShift!
                                                          .toString()
                                                      : selectedIndex == 2
                                                          ? context
                                                              .read<
                                                                  WorkLocationDetailsCubit>()
                                                              .attendanceHistoryOrganizationModel!
                                                              .data!
                                                              .data![index]
                                                              .endShift!
                                                              .toString()
                                                          : selectedIndex == 3
                                                              ? context
                                                                  .read<
                                                                      WorkLocationDetailsCubit>()
                                                                  .attendanceHistoryBuildingModel!
                                                                  .data!
                                                                  .data![index]
                                                                  .endShift!
                                                                  .toString()
                                                              : selectedIndex ==
                                                                      4
                                                                  ? context
                                                                      .read<
                                                                          WorkLocationDetailsCubit>()
                                                                      .attendanceHistoryFloorModel!
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .endShift!
                                                                      .toString()
                                                                  : selectedIndex ==
                                                                          5
                                                                      ? context
                                                                          .read<
                                                                              WorkLocationDetailsCubit>()
                                                                          .attendanceHistorySectionModel!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .endShift!
                                                                          .toString()
                                                                      : context
                                                                          .read<
                                                                              WorkLocationDetailsCubit>()
                                                                          .attendanceHistoryPointModel!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .endShift!
                                                                          .toString()))
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
                    TextSpan(
                      text: formatTime(selectedIndex == 0
                          ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .attendanceHistoryAreaModel!
                                  .data!
                                  .data![index]
                                  .clockIn ??
                              ''
                          : selectedIndex == 1
                              ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .attendanceHistoryCityModel!
                                      .data!
                                      .data![index]
                                      .clockIn ??
                                  ''
                              : selectedIndex == 2
                                  ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .attendanceHistoryOrganizationModel!
                                          .data!
                                          .data![index]
                                          .clockIn ??
                                      ''
                                  : selectedIndex == 3
                                      ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .attendanceHistoryBuildingModel!
                                              .data!
                                              .data![index]
                                              .clockIn ??
                                          ''
                                      : selectedIndex == 4
                                          ? context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .attendanceHistoryFloorModel!
                                                  .data!
                                                  .data![index]
                                                  .clockIn ??
                                              ''
                                          : selectedIndex == 5
                                              ? context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistorySectionModel!
                                                      .data!
                                                      .data![index]
                                                      .clockIn ??
                                                  ''
                                              : context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryPointModel!
                                                      .data!
                                                      .data![index]
                                                      .clockIn ??
                                                  ''),
                      style: TextStyles.font12GreyRegular
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    TextSpan(
                      text: '  -  ',
                      style: TextStyles.font12GreyRegular
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    TextSpan(
                      text: formatTime(selectedIndex == 0
                          ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .attendanceHistoryAreaModel!
                                  .data!
                                  .data![index]
                                  .clockOut ??
                              ''
                          : selectedIndex == 1
                              ? context
                                      .read<WorkLocationDetailsCubit>()
                                      .attendanceHistoryCityModel!
                                      .data!
                                      .data![index]
                                      .clockOut ??
                                  ''
                              : selectedIndex == 2
                                  ? context
                                          .read<WorkLocationDetailsCubit>()
                                          .attendanceHistoryOrganizationModel!
                                          .data!
                                          .data![index]
                                          .clockOut ??
                                      ''
                                  : selectedIndex == 3
                                      ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .attendanceHistoryBuildingModel!
                                              .data!
                                              .data![index]
                                              .clockOut ??
                                          ''
                                      : selectedIndex == 4
                                          ? context
                                                  .read<WorkLocationDetailsCubit>()
                                                  .attendanceHistoryFloorModel!
                                                  .data!
                                                  .data![index]
                                                  .clockOut ??
                                              ''
                                          : selectedIndex == 5
                                              ? context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistorySectionModel!
                                                      .data!
                                                      .data![index]
                                                      .clockOut ??
                                                  ''
                                              : context
                                                      .read<WorkLocationDetailsCubit>()
                                                      .attendanceHistoryPointModel!
                                                      .data!
                                                      .data![index]
                                                      .clockOut ??
                                                  ''),
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
                      text: 'Duration : ',
                      style: TextStyles.font12GreyRegular
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    TextSpan(
                      text: formatDuration(
                        selectedIndex == 0
                            ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .attendanceHistoryAreaModel!
                                    .data!
                                    .data![index]
                                    .duration ??
                                ''
                            : selectedIndex == 1
                                ? context
                                        .read<WorkLocationDetailsCubit>()
                                        .attendanceHistoryCityModel!
                                        .data!
                                        .data![index]
                                        .duration ??
                                    ''
                                : selectedIndex == 2
                                    ? context
                                            .read<WorkLocationDetailsCubit>()
                                            .attendanceHistoryOrganizationModel!
                                            .data!
                                            .data![index]
                                            .duration ??
                                        ''
                                    : selectedIndex == 3
                                        ? context
                                                .read<WorkLocationDetailsCubit>()
                                                .attendanceHistoryBuildingModel!
                                                .data!
                                                .data![index]
                                                .duration ??
                                            ''
                                        : selectedIndex == 4
                                            ? context
                                                    .read<WorkLocationDetailsCubit>()
                                                    .attendanceHistoryFloorModel!
                                                    .data!
                                                    .data![index]
                                                    .duration ??
                                                ''
                                            : selectedIndex == 5
                                                ? context
                                                        .read<
                                                            WorkLocationDetailsCubit>()
                                                        .attendanceHistorySectionModel!
                                                        .data!
                                                        .data![index]
                                                        .duration ??
                                                    ''
                                                : context
                                                        .read<
                                                            WorkLocationDetailsCubit>()
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
