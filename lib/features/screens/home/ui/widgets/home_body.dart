import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_app_bar.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String formatDuration(String? duration) {
    if (duration == null) return '--:--';

    List<String> parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    if (hours == 0 && minutes == 0) {
      return "0 min";
    } else if (hours == 0) {
      return "$minutes min";
    } else if (minutes == 0) {
      return "$hours hr";
    } else {
      return "$hours hr, $minutes min";
    }
  }

  @override
  void initState() {
    context.read<HomeCubit>().getUserDetails();
    if (role != 'Admin') {
      context.read<HomeCubit>().getUserStatus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ClockInOutSuccessState) {
              toast(text: state.message, color: Colors.blue);
            }
            if (state is ClockInOutErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (role == 'Admin' &&
                context.read<HomeCubit>().profileModel == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            if (role != 'Admin' &&
                context.read<HomeCubit>().attendanceHistoryModel == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                homeAppBar(context),
                verticalSpace(10),
                // if (role != 'Admin')
                //   Padding(
                //     padding: const EdgeInsets.all(20),
                //     child: Column(
                //       children: [
                //         Card(
                //           elevation: 1,
                //           margin: EdgeInsets.zero,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(11.r),
                //           ),
                //           child: Container(
                //             constraints: BoxConstraints(
                //               minHeight: 244.h,
                //             ),
                //             width: double.infinity,
                //             padding: EdgeInsets.zero,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(11.r),
                //               border:
                //                   Border.all(color: AppColor.secondaryColor),
                //             ),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceAround,
                //                   children: [
                //                     Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Text(
                //                               'Clock-In',
                //                               style:
                //                                   TextStyles.font12GreyRegular,
                //                             ),
                //                             horizontalSpace(5),
                //                             Container(
                //                               width: 5.w,
                //                               height: 5.h,
                //                               clipBehavior: Clip.hardEdge,
                //                               decoration: BoxDecoration(
                //                                   color: Colors.green,
                //                                   shape: BoxShape.circle),
                //                             )
                //                           ],
                //                         ),
                //                         verticalSpace(5),
                //                         Text(
                //                           context
                //                                       .read<HomeCubit>()
                //                                       .attendanceHistoryModel!
                //                                       .data!
                //                                       .data![0]
                //                                       .clockIn !=
                //                                   null
                //                               ? DateFormat('HH:mm').format(
                //                                   DateTime.parse(context
                //                                       .read<HomeCubit>()
                //                                       .attendanceHistoryModel!
                //                                       .data!
                //                                       .data!
                //                                       .first
                //                                       .clockIn!),
                //                                 )
                //                               : '--:--',
                //                           style: TextStyles.font14BlackSemiBold,
                //                         ),
                //                       ],
                //                     ),
                //                     Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Text(
                //                               'Clock-Out',
                //                               style:
                //                                   TextStyles.font12GreyRegular,
                //                             ),
                //                             horizontalSpace(5),
                //                             Container(
                //                               width: 5.w,
                //                               height: 5.h,
                //                               clipBehavior: Clip.hardEdge,
                //                               decoration: BoxDecoration(
                //                                   color: Colors.red,
                //                                   shape: BoxShape.circle),
                //                             )
                //                           ],
                //                         ),
                //                         verticalSpace(5),
                //                         Text(
                //                           context
                //                                   .read<HomeCubit>()
                //                                   .attendanceHistoryModel!
                //                                   .data!
                //                                   .data!
                //                                   .first
                //                                   .clockOut!
                //                                   .isNotEmpty
                //                               ? DateFormat('HH:mm').format(
                //                                   DateTime.parse(context
                //                                       .read<HomeCubit>()
                //                                       .attendanceHistoryModel!
                //                                       .data!
                //                                       .data!
                //                                       .first
                //                                       .clockOut!),
                //                                 )
                //                               : '--:--',
                //                           style: TextStyles.font14BlackSemiBold,
                //                         ),
                //                       ],
                //                     ),
                //                     Column(
                //                       children: [
                //                         Text(
                //                           'Duration',
                //                           style: TextStyles.font12GreyRegular,
                //                         ),
                //                         verticalSpace(5),
                //                         Text(
                //                           formatDuration(context
                //                               .read<HomeCubit>()
                //                               .attendanceHistoryModel!
                //                               .data!
                //                               .data!
                //                               .first
                //                               .duration),
                //                           style: TextStyles.font14BlackSemiBold,
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //                 InkWell(
                //                   onTap: () {
                //                     context.read<HomeCubit>().clockInOut();
                //                   },
                //                   child: Center(
                //                     child: Container(
                //                       width: 85.w,
                //                       height: 85.h,
                //                       clipBehavior: Clip.hardEdge,
                //                       decoration: BoxDecoration(
                //                         color: context
                //                                 .read<HomeCubit>()
                //                                 .attendanceHistoryModel!
                //                                 .data!
                //                                 .data![0]
                //                                 .clockOut!
                //                                 .isEmpty
                //                             ? Colors.red
                //                             : AppColor.primaryColor,
                //                         shape: BoxShape.circle,
                //                         boxShadow: [
                //                           BoxShadow(
                //                               offset: Offset(0, 1),
                //                               color: AppColor.thirdColor)
                //                         ],
                //                       ),
                //                       child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.center,
                //                         children: [
                //                           Image.asset(
                //                             'assets/images/click.png',
                //                           ),
                //                           verticalSpace(5),
                //                           Text(
                //                             context
                //                                     .read<HomeCubit>()
                //                                     .attendanceHistoryModel!
                //                                     .data!
                //                                     .data![0]
                //                                     .clockOut!
                //                                     .isEmpty
                //                                 ? 'Clock out'
                //                                 : 'Clock in',
                //                             style:
                //                                 TextStyles.font11WhiteSemiBold,
                //                           )
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 RichText(
                //                   textAlign: TextAlign.center,
                //                   text: TextSpan(
                //                     children: [
                //                       TextSpan(
                //                         text: context
                //                                     .read<HomeCubit>()
                //                                     .attendanceHistoryModel
                //                                     ?.data
                //                                     ?.data![0]
                //                                     .date !=
                //                                 null
                //                             ? "${DateFormat('EEEE').format(DateTime.parse(context.read<HomeCubit>().attendanceHistoryModel!.data!.data![0].date!))}, "
                //                             : 'Day,',
                //                         style: TextStyles.font20PrimMedium,
                //                       ),
                //                       TextSpan(
                //                         text: context
                //                                 .read<HomeCubit>()
                //                                 .attendanceHistoryModel!
                //                                 .data!
                //                                 .data![0]
                //                                 .date ??
                //                             '--/--/----',
                //                         style: TextStyles.font20PrimMedium,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   )
              ],
            );
          },
        ),
      ),
    ));
  }
}
