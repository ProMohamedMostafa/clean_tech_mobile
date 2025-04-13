import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';

Widget buildCardItem(BuildContext context, index) {
  String formatDuration(String? duration) {
    if (duration == null || duration.isEmpty || !duration.contains(':')) {
      return 'N/A';
    }

    final durationParts = duration.split(':');

    if (durationParts.length < 2) {
      return 'N/A';
    }

    final hours = int.tryParse(durationParts[0]) ?? 0;
    final minutes = int.tryParse(durationParts[1]) ?? 0;

    if (hours > 0) {
      return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      return '$minutes min';
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

  historystatus = context
      .read<AttendanceHistoryCubit>()
      .attendanceHistoryModel!
      .data!
      .data![index]
      .status!;

  if (status.contains(historystatus)) {
    statusColorForTask = statusColor[status.indexOf(historystatus)];
  } else {
    statusColorForTask = Colors.black;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
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
                      context
                          .read<AttendanceHistoryCubit>()
                          .attendanceHistoryModel!
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
                        DateTime.parse(context
                            .read<AttendanceHistoryCubit>()
                            .attendanceHistoryModel!
                            .data!
                            .data![index]
                            .date!),
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
                      context
                          .read<AttendanceHistoryCubit>()
                          .attendanceHistoryModel!
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
              context
                  .read<AttendanceHistoryCubit>()
                  .attendanceHistoryModel!
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
                    text: context
                                .read<AttendanceHistoryCubit>()
                                .attendanceHistoryModel!
                                .data!
                                .data![index]
                                .startShift !=
                            null
                        ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss')
                            .parse(context
                                .read<AttendanceHistoryCubit>()
                                .attendanceHistoryModel!
                                .data!
                                .data![index]
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
                    text: context
                                .read<AttendanceHistoryCubit>()
                                .attendanceHistoryModel!
                                .data!
                                .data![index]
                                .endShift !=
                            null
                        ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss')
                            .parse(context
                                .read<AttendanceHistoryCubit>()
                                .attendanceHistoryModel!
                                .data!
                                .data![index]
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
                        text: DateFormat('HH:mm').format(
                          DateTime.parse(context
                              .read<AttendanceHistoryCubit>()
                              .attendanceHistoryModel!
                              .data!
                              .data![index]
                              .clockIn!),
                        ),
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: '  -  ',
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: context
                                    .read<AttendanceHistoryCubit>()
                                    .attendanceHistoryModel
                                    ?.data
                                    ?.data?[index]
                                    .clockOut !=
                                null
                            ? DateFormat('HH:mm').format(
                                DateTime.parse(context
                                    .read<AttendanceHistoryCubit>()
                                    .attendanceHistoryModel!
                                    .data!
                                    .data![index]
                                    .clockOut!),
                              )
                            : '  :  ',
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
                          context
                              .read<AttendanceHistoryCubit>()
                              .attendanceHistoryModel!
                              .data!
                              .data![index]
                              .duration,
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
    ),
  );
}
