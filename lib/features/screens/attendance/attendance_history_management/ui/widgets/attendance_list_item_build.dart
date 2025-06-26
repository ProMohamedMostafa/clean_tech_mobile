import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class HistoryListItem extends StatelessWidget {
  final int index;
  const HistoryListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceHistoryCubit>();
    return Card(
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
                        .getStatusColor(cubit
                            .attendanceHistoryModel!.data!.data![index].status!)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      cubit.attendanceHistoryModel!.data!.data![index].status!,
                      style: TextStyles.font11WhiteSemiBold.copyWith(
                        color: cubit.getStatusColor(cubit
                            .attendanceHistoryModel!
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
                        DateTime.parse(cubit
                            .attendanceHistoryModel!.data!.data![index].date!),
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
                      cubit.attendanceHistoryModel!.data!.data![index].role!,
                      style: TextStyles.font11WhiteSemiBold
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            Text(
              cubit.attendanceHistoryModel!.data!.data![index].userName!,
              style: TextStyles.font16BlackSemiBold,
            ),
            verticalSpace(10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).shift,
                    style: TextStyles.font12GreyRegular,
                  ),
                  TextSpan(
                    text: cubit.attendanceHistoryModel!.data!.data![index]
                                .startShift !=
                            null
                        ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss')
                            .parse(cubit.attendanceHistoryModel!.data!
                                .data![index].startShift!
                                .toString()))
                        : '--',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                  TextSpan(
                    text: '  --  ',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                  TextSpan(
                    text: cubit.attendanceHistoryModel!.data!.data![index]
                                .endShift !=
                            null
                        ? DateFormat('hh:mm a').format(DateFormat('HH:mm:ss')
                            .parse(cubit.attendanceHistoryModel!.data!
                                .data![index].endShift!
                                .toString()))
                        : '--',
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.thirdColor),
                  ),
                ],
              ),
            ),
            verticalSpace(10),
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
                          DateTime.parse(cubit.attendanceHistoryModel!.data!
                              .data![index].clockIn!),
                        ),
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: '  --  ',
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      TextSpan(
                        text: cubit.attendanceHistoryModel?.data?.data?[index]
                                    .clockOut !=
                                null
                            ? DateFormat('HH:mm').format(
                                DateTime.parse(cubit.attendanceHistoryModel!
                                    .data!.data![index].clockOut!),
                              )
                            : '',
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
                          cubit.attendanceHistoryModel!.data!.data![index]
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
    );
  }
}
