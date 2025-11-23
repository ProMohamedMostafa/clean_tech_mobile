import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ClockInOutBody extends StatelessWidget {
  const ClockInOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ClockInOutSuccessState) {
          toast(text: state.message, isSuccess: true);
        }
        if (state is ClockInOutErrorState) {
          toast(text: state.error, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final clockIn = cubit.attendanceStatusModel?.data?.clockIn;
        final clockOut = cubit.attendanceStatusModel?.data?.clockOut;
        final duration = cubit.attendanceStatusModel?.data?.duration;

        final isClockedIn = clockIn != null && clockOut == null;
        final isClockedOut = clockOut != null;
        final color = isClockedIn ? Colors.red : AppColor.primaryColor;
        final text =
            isClockedIn ? S.of(context).clock_out : S.of(context).clock_in;

        Widget clockButton = Center(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: color,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/click.png',
                  color: Colors.white,
                  width: 22.w,
                  height: 22.h,
                ),
                horizontalSpace(5),
                Text(
                  text,
                  style: TextStyles.font11lightPrimary.copyWith(
                    color: Colors.white,
                  ),
                ),
                horizontalSpace(5),
              ],
            ),
          ),
        );

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Clock-In
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      style: TextStyles.font12PrimSemi,
                    ),
                    verticalSpace(5),
                    Row(
                      children: [
                        Text(
                          S.of(context).clock_in,
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
                      clockIn != null
                          ? DateFormat('hh:mm a')
                              .format(cubit.parseUtc(clockIn))
                          : '--:-- --',
                      style: TextStyles.font14BlackSemiBold,
                    ),
                  ],
                ),

                // Clock-Out
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).clock_out,
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
                      clockOut != null
                          ? DateFormat('hh:mm a')
                              .format(cubit.parseUtc(clockOut))
                          : '--:-- --',
                      style: TextStyles.font14BlackSemiBold,
                    ),
                  ],
                ),

                // Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).duration2,
                      style: TextStyles.font12GreyRegular,
                    ),
                    verticalSpace(5),
                    Text(
                      duration != null
                          ? cubit.formatDuration(duration)
                          : '--:--:--',
                      style: TextStyles.font14BlackSemiBold,
                    ),
                  ],
                ),

                if (!isClockedOut)
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return PopUpMessage(
                            title: text,
                            body: S.of(context).time2,
                            onPressed: () {
                              cubit.clockInOut();
                            },
                          );
                        },
                      );
                    },
                    child: clockButton,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
