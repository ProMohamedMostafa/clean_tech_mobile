import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';

class ClockInOutBody extends StatelessWidget {
  const ClockInOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ClockInOutErrorState) {
          toast(text: state.error, color: Colors.red);
        }
        if (state is ClockInOutSuccessState) {
          toast(text: state.message, color: Colors.blue);
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyles.font12PrimSemi,
                      ),
                      verticalSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Clock-In
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Clock-In',
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  horizontalSpace(5),
                                  Container(
                                    width: 5.w,
                                    height: 5.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(5),
                              Text(
                                cubit.attendanceStatusModel?.data?.clockIn !=
                                        null
                                    ? DateFormat('hh:mm a').format(
                                        DateTime.parse(cubit
                                            .attendanceStatusModel!
                                            .data!
                                            .clockIn!))
                                    : '--:-- --',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                            ],
                          ),

                          // Clock-Out
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Clock-Out',
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  horizontalSpace(5),
                                  Container(
                                    width: 5.w,
                                    height: 5.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(5),
                              Text(
                                cubit.attendanceStatusModel?.data?.clockOut !=
                                        null
                                    ? DateFormat('hh:mm a').format(
                                        DateTime.parse(cubit
                                            .attendanceStatusModel!
                                            .data!
                                            .clockOut!))
                                    : '--:-- --',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                            ],
                          ),

                          // Duration
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Duration',
                                style: TextStyles.font12GreyRegular,
                              ),
                              verticalSpace(5),
                              Text(
                                cubit.attendanceStatusModel?.data?.duration !=
                                        null
                                    ? cubit.formatDuration(cubit
                                        .attendanceStatusModel!.data!.duration!)
                                    : '--:--:--',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                horizontalSpace(12),
                GestureDetector(
                  onTap: () {
                    if (cubit.attendanceStatusModel?.data == null ||
                        cubit.attendanceStatusModel?.data?.clockOut == null) {
                      cubit.clockInOut();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 65.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: (cubit.attendanceStatusModel?.data == null ||
                                cubit.attendanceStatusModel?.data?.clockIn ==
                                    null)
                            ? AppColor.primaryColor
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2.w,
                            color: (cubit.attendanceStatusModel?.data == null ||
                                    cubit.attendanceStatusModel?.data
                                            ?.clockIn ==
                                        null)
                                ? const Color(0xff67CF42)
                                : Colors.red),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/click.png',
                              color:
                                  (cubit.attendanceStatusModel?.data == null ||
                                          cubit.attendanceStatusModel?.data
                                                  ?.clockIn ==
                                              null)
                                      ? const Color(0xff00EB19)
                                      : Colors.red,
                              width: 20.w,
                              height: 20.h,
                            ),
                            verticalSpace(5),
                            Text(
                              (cubit.attendanceStatusModel?.data == null ||
                                      cubit.attendanceStatusModel?.data
                                              ?.clockIn ==
                                          null)
                                  ? 'Clock in'
                                  : 'Clock out',
                              style: TextStyles.font10lightPrimary.copyWith(
                                color: (cubit.attendanceStatusModel?.data ==
                                            null ||
                                        cubit.attendanceStatusModel?.data
                                                ?.clockIn ==
                                            null)
                                    ? const Color(0xff00EB19)
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
