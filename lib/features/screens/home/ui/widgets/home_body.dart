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
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ChartData? selectedData;
  int? selectedIndex;
  final List<ChartData> chartDataList = [
    ChartData('Jan', 65),
    ChartData('Feb', 70),
    ChartData('Mar', 75),
    ChartData('Apr', 67),
    ChartData('May', 38),
    ChartData('Jun', 90),
  ];
  final List<Color> colorMap = [
    AppColor.primaryColor,
    Colors.green,
    Colors.cyan,
    Colors.greenAccent,
    Colors.blue,
    Colors.teal,
  ];

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
            if (context.read<HomeCubit>().profileModel == null) {
              return Center(
                child: Image.asset(
                  'assets/images/loading.gif',
                  width: 120.w,
                  height: 120.h,
                  fit: BoxFit.contain,
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(5),
                  homeAppBar(context),
                  verticalSpace(15),
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                        leading: Icon(
                          Icons.timeline_sharp,
                          color: AppColor.primaryColor,
                          size: 22.sp,
                        ),
                        title: Text(
                          'Show Activity',
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        trailing: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColor.primaryColor,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 90.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/stock.png',
                                      height: 25.h,
                                      width: 25.w,
                                      fit: BoxFit.fill,
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      'Low Stock',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                Row(
                                  children: [
                                    Text(
                                      '220',
                                      style: TextStyles.font18PrimBold,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 20.h,
                                      width: 50.w,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                          border: Border.all(
                                              color: AppColor.primaryColor)),
                                      child: Center(
                                        child: Text(
                                          '80%',
                                          style: TextStyles.font11lightPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Container(
                          height: 90.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_outlined,
                                      color: AppColor.primaryColor,
                                      size: 24.sp,
                                    ),
                                    horizontalSpace(2),
                                    Text(
                                      'In Cost',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 61.w,
                                      height: 22.h,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        border: Border.all(
                                            color: AppColor.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: PopupMenuButton<String>(
                                        padding: EdgeInsets.zero,
                                        color: Colors.white,
                                        icon: SizedBox.expand(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Month',
                                                    style: TextStyles
                                                        .font12PrimSemi),
                                                RotatedBox(
                                                  quarterTurns: 1,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color:
                                                        AppColor.primaryColor,
                                                    size: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        menuPadding: EdgeInsets.zero,
                                        itemBuilder: (context) => [
                                          _buildPopupItem('1', 'January'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('2', 'February'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('3', 'March'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('4', 'April'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('5', 'May'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('6', 'June'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('7', 'July'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('8', 'August'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('9', 'September'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('10', 'October'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('11', 'November'),
                                          const PopupMenuDivider(height: 0.5),
                                          _buildPopupItem('12', 'December'),
                                        ],
                                        onSelected: (value) {},
                                        offset: Offset(0, 22.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 61.w,
                                          maxHeight: (28.h * 4) + (0.5 * 3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                Row(
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '75.5 ',
                                            style: TextStyles.font18PrimBold,
                                          ),
                                          TextSpan(
                                            text: '\$',
                                            style: TextStyles.font18PrimBold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 20.h,
                                      width: 50.w,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                          border: Border.all(
                                              color: AppColor.primaryColor)),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              '10%',
                                              style:
                                                  TextStyles.font11lightPrimary,
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.trending_up_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.groups,
                                      color: AppColor.primaryColor,
                                      size: 24.sp,
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      'Total Users ',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                    Spacer(),
                                    Text(
                                      '650',
                                      style: TextStyles.font14Primarybold,
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                // Present and Late row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Admin',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('10',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Manager',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('2',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Supervisor',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('7',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Cleaner',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('3',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.fact_check_outlined,
                                      color: AppColor.primaryColor,
                                      size: 24.sp,
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      'Attendance',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                // Present and Late row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Present',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('10',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Late',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('2',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Absent',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('7',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Leaves',
                                                style:
                                                    TextStyles.font11lightblack,
                                              ),
                                            ],
                                          ),
                                          Text('3',
                                              style: TextStyles
                                                  .font11lightPrimary),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_rounded,
                                color: AppColor.primaryColor,
                                size: 24.sp,
                              ),
                              horizontalSpace(8),
                              Text(
                                'Total Shifts',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                              Spacer(),
                              Container(
                                height: 20.h,
                                width: 50.w,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(3.r),
                                    border: Border.all(
                                        color: AppColor.primaryColor)),
                                child: Center(
                                  child: Text(
                                    '100%',
                                    style: TextStyles.font11lightPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '130',
                                style: TextStyles.font18PrimBold,
                              ),
                              horizontalSpace(30),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 7.w,
                                      height: 7.h,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      'un Active 30',
                                      style: TextStyles.font11BlackMedium,
                                    ),
                                    horizontalSpace(8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14.sp,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 7.w,
                                      height: 7.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      'in Active 100',
                                      style: TextStyles.font11BlackMedium,
                                    ),
                                    horizontalSpace(8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14.sp,
                                      color: AppColor.primaryColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Container(
                    height: 350.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Stock Quantity',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                    TextSpan(
                                      text: ' (650)',
                                      style: TextStyles.font14Primarybold,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 110.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          horizontalSpace(30),
                                          Text('All',
                                              style:
                                                  TextStyles.font12BlackSemi),
                                          horizontalSpace(30),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 130.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Chart Type: ',
                                                  style: TextStyles
                                                      .font12BlackSemi,
                                                ),
                                                TextSpan(
                                                  text: ' Line',
                                                  style:
                                                      TextStyles.font12PrimSemi,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 150.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: AppColor.primaryColor,
                                            size: 16.sp,
                                          ),
                                          horizontalSpace(5),
                                          Text(
                                            'Jan - Jun 2024',
                                            style: TextStyles.font12BlackSemi,
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10),
                          SizedBox(
                            height: 200.h,
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                labelPlacement: LabelPlacement.onTicks,
                                majorGridLines: const MajorGridLines(width: 0),
                                axisLine:
                                    AxisLine(width: 1, color: Colors.grey[200]),
                                majorTickLines: const MajorTickLines(width: 0),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 200,
                                interval: 50,
                                majorGridLines: MajorGridLines(
                                  color: Colors.grey[200],
                                  width: 1,
                                ),
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(width: 0),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              plotAreaBorderWidth: 0,
                              series: <CartesianSeries>[
                                SplineSeries<ChartData, String>(
                                  // Changed to SplineSeries for smooth curves
                                  name: 'In',
                                  dataSource: [
                                    ChartData('Jan', 120),
                                    ChartData('Feb', 150),
                                    ChartData('Mar', 100),
                                    ChartData('Apr', 80),
                                    ChartData('May', 180),
                                    ChartData('Jun', 160),
                                  ],
                                  xValueMapper: (ChartData data, _) =>
                                      data.month,
                                  yValueMapper: (ChartData data, _) =>
                                      data.value,
                                  color: AppColor.primaryColor,
                                  splineType: SplineType.cardinal,
                                  cardinalSplineTension: 0.8,
                                  markerSettings: MarkerSettings(
                                    isVisible: true,
                                    shape: DataMarkerType.circle,
                                    borderWidth: 2,
                                    borderColor: Colors.white, // White ring
                                    color: AppColor
                                        .primaryColor, // Inner solid color
                                    width: 10, // Inner circle size
                                    height: 10,
                                  ),
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    labelAlignment: ChartDataLabelAlignment.top,
                                    offset: Offset(0, 6),
                                  ),
                                ),
                                SplineSeries<ChartData, String>(
                                  // Changed to SplineSeries for smooth curves
                                  name: 'Out',
                                  dataSource: [
                                    ChartData('Jan', 80),
                                    ChartData('Feb', 60),
                                    ChartData('Mar', 90),
                                    ChartData('Apr', 70),
                                    ChartData('May', 120),
                                    ChartData('Jun', 100),
                                  ],
                                  xValueMapper: (ChartData data, _) =>
                                      data.month,
                                  yValueMapper: (ChartData data, _) =>
                                      data.value,
                                  color: const Color(0xff46B749),
                                  splineType: SplineType
                                      .cardinal, // Makes the curve smooth and wave-like
                                  cardinalSplineTension:
                                      0.8, // Adjusts the curve tension (0.0-1.0)
                                  markerSettings: MarkerSettings(
                                    isVisible: true,
                                    borderWidth: 2,
                                    borderColor: Colors.white,
                                    shape: DataMarkerType.circle,
                                    color: const Color(0xff46B749),
                                    width: 10, // Inner circle size
                                    height: 10,
                                  ),
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      color: const Color(0xff46B749),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    labelAlignment:
                                        ChartDataLabelAlignment.bottom,
                                    offset: Offset(0, 6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 200.h,
                          //   child: SfCartesianChart(
                          //     primaryXAxis: CategoryAxis(
                          //       labelPlacement: LabelPlacement.onTicks,
                          //       majorGridLines: const MajorGridLines(width: 0),
                          //       axisLine:
                          //           AxisLine(width: 1, color: Colors.grey[200]),
                          //       majorTickLines: const MajorTickLines(width: 0),
                          //       labelStyle: TextStyle(color: Colors.black),
                          //     ),
                          //     primaryYAxis: NumericAxis(
                          //       minimum: 0,
                          //       maximum: 200,
                          //       interval: 50,
                          //       majorGridLines: MajorGridLines(
                          //         color: Colors.grey[200],
                          //         width: 1,
                          //       ),
                          //       axisLine: const AxisLine(width: 0),
                          //       majorTickLines: const MajorTickLines(width: 0),
                          //       labelStyle: TextStyle(color: Colors.black),
                          //     ),
                          //     plotAreaBorderWidth: 0,
                          //     series: <CartesianSeries>[
                          //       ColumnSeries<ChartData, String>(
                          //         name: 'In',
                          //         dataSource: [
                          //           ChartData('Jan', 120),
                          //           ChartData('Feb', 150),
                          //           ChartData('Mar', 100),
                          //           ChartData('Apr', 80),
                          //           ChartData('May', 180),
                          //           ChartData('Jun', 160),
                          //         ],
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         color: AppColor.primaryColor,
                          //         width: 0.6, // Adjust column width
                          //         spacing: 0.2, // Space between columns
                          //       ),
                          //       ColumnSeries<ChartData, String>(
                          //         name: 'Out',
                          //         dataSource: [
                          //           ChartData('Jan', 80),
                          //           ChartData('Feb', 60),
                          //           ChartData('Mar', 90),
                          //           ChartData('Apr', 70),
                          //           ChartData('May', 120),
                          //           ChartData('Jun', 100),
                          //         ],
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         color: const Color(0xff46B749),
                          //         width: 0.6, // Adjust column width
                          //         spacing: 0.2, // Space between columns
                          //       ),
                          //     ],
                          //     tooltipBehavior: TooltipBehavior(
                          //       enable: true,
                          //       header: '',
                          //       format: 'point.x : point.y',
                          //     ),
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: 200.h,
                          //   child: SfCircularChart(
                          //     series: <CircularSeries>[
                          //       PieSeries<ChartData, String>(
                          //         dataSource: [
                          //           ChartData('Dense', 80),
                          //           ChartData('Other', 20),
                          //         ],
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         // Customize the colors as needed
                          //         pointColorMapper: (ChartData data, _) =>
                          //             data.month == 'Dense'
                          //                 ? AppColor.primaryColor
                          //                 : const Color(0xff46B749),
                          //         dataLabelSettings: DataLabelSettings(
                          //           isVisible: true,
                          //           labelPosition:
                          //               ChartDataLabelPosition.outside,
                          //           textStyle: TextStyle(
                          //             color: Colors.black,
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //           connectorLineSettings:
                          //               ConnectorLineSettings(
                          //             length: '20%',
                          //             type: ConnectorType.curve,
                          //           ),
                          //           // labelFormat: '{point.y}%',
                          //         ),
                          //         radius: '90%',
                          //         explode: true,
                          //         explodeIndex: 0,
                          //         explodeOffset: '10%',
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegend('In side', AppColor.primaryColor),
                                SizedBox(width: 16),
                                _buildLegend('Out side', Color(0xff46B749)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Completion Tasks rate',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                              Spacer(),
                              Container(
                                width: 110.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          horizontalSpace(30),
                                          Text('All',
                                              style:
                                                  TextStyles.font12BlackSemi),
                                          horizontalSpace(30),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 130.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Chart Type: ',
                                                  style: TextStyles
                                                      .font12BlackSemi,
                                                ),
                                                TextSpan(
                                                  text: ' Line',
                                                  style:
                                                      TextStyles.font12PrimSemi,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 150.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: AppColor.primaryColor,
                                            size: 16.sp,
                                          ),
                                          horizontalSpace(5),
                                          Text(
                                            'Jan - Jun 2024',
                                            style: TextStyles.font12BlackSemi,
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10),
                          // SizedBox(
                          //   height: 200.h,
                          //   child: SfCartesianChart(
                          //     primaryXAxis: CategoryAxis(
                          //       labelPlacement: LabelPlacement.betweenTicks,
                          //       axisLine:
                          //           AxisLine(width: 1.w, color: Colors.black),
                          //       majorTickLines: const MajorTickLines(width: 0),
                          //       labelStyle: TextStyle(color: Colors.black),
                          //       majorGridLines: MajorGridLines(
                          //         color: Colors.grey[200],
                          //         width: 1.w,
                          //       ),
                          //     ),
                          //     primaryYAxis: NumericAxis(
                          //       minimum: 0,
                          //       maximum: 100,
                          //       interval: 20,
                          //       majorGridLines: MajorGridLines(
                          //         color: Colors.grey[200],
                          //         width: 1.w,
                          //       ),
                          //       axisLine: const AxisLine(width: 0),
                          //       majorTickLines: const MajorTickLines(width: 0),
                          //       labelStyle: TextStyle(color: Colors.black),
                          //     ),
                          //     plotAreaBorderWidth: 0,
                          //     series: <CartesianSeries>[
                          //       ColumnSeries<ChartData, String>(
                          //         name: 'Percentage',
                          //         dataSource: [
                          //           ChartData('Jan', 65),
                          //           ChartData('Feb', 70),
                          //           ChartData('Mar', 75),
                          //           ChartData('Apr', 67),
                          //           ChartData('May', 38),
                          //           ChartData('Jun', 90),
                          //         ],
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         color: AppColor.primaryColor,
                          //         dataLabelSettings: DataLabelSettings(
                          //           isVisible: true,
                          //           textStyle: TextStyles.font11Whitelight,
                          //           labelAlignment:
                          //               ChartDataLabelAlignment.middle,
                          //           offset: Offset(0, 3),
                          //         ),
                          //         dataLabelMapper: (ChartData data, _) =>
                          //             '${data.value}%',
                          //         trackColor:
                          //             Color(0xffD6E9F4).withOpacity(0.7),
                          //         trackBorderColor: Colors.transparent,
                          //         trackPadding: 0,
                          //         isTrackVisible: true,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 200.h,
                          //   child: SfCircularChart(
                          //     series: <CircularSeries>[
                          //       RadialBarSeries<ChartData, String>(
                          //         dataSource: chartDataList,
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         pointColorMapper: (ChartData data, _) =>
                          //             AppColor.primaryColor,
                          //         trackColor: Colors.grey.shade300,
                          //         maximumValue: 100,
                          //         radius: '120%',
                          //         gap: '8%',
                          //         cornerStyle: CornerStyle.endCurve,
                          //         trackOpacity: 0.8,
                          //         innerRadius: '35%',
                          //         useSeriesColor: false,
                          //         dataLabelSettings:
                          //             DataLabelSettings(isVisible: false),
                          //         onPointTap: (ChartPointDetails details) {
                          //           setState(() {
                          //             selectedData =
                          //                 chartDataList[details.pointIndex!];
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //     annotations: <CircularChartAnnotation>[
                          //       CircularChartAnnotation(
                          //         widget: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Text(
                          //               selectedData != null
                          //                   ? '${selectedData!.value}%'
                          //                   : '',
                          //               style: TextStyles.font16PrimSemiBold,
                          //             ),
                          //             Text(
                          //               selectedData?.month ?? '',
                          //               style: TextStyles.font14BlackSemiBold,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          SizedBox(
                            width: double.infinity,
                            height: 200.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: chartDataList.length * 60,
                                child: SfCartesianChart(
                                  margin: EdgeInsets.zero,
                                  borderWidth: 0,
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                    majorTickLines: MajorTickLines(size: 1),
                                    labelRotation: 0,
                                    labelPlacement: LabelPlacement.onTicks,
                                    minimum: 0,
                                    maximum: chartDataList.length - 1,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    majorGridLines: MajorGridLines(
                                      width: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    majorTickLines: MajorTickLines(size: 0),
                                    axisLine: AxisLine(width: 0),
                                  ),
                                  series: <CartesianSeries>[
                                    SplineAreaSeries<ChartData, String>(
                                      dataSource: chartDataList,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.primaryColor
                                              .withOpacity(0.5),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderColor: AppColor.primaryColor,
                                      borderWidth: 3,
                                      splineType: SplineType.clamped,
                                      xValueMapper: (ChartData data, _) =>
                                          data.month,
                                      yValueMapper: (ChartData data, _) =>
                                          data.value,
                                      markerSettings: MarkerSettings(
                                        isVisible: true,
                                        shape: DataMarkerType.circle,
                                        borderColor: AppColor.primaryColor,
                                        color: AppColor.primaryColor,
                                      ),
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        labelAlignment:
                                            ChartDataLabelAlignment.top,
                                        textStyle:
                                            TextStyles.font10lightPrimary,
                                        offset: Offset(0, 3),
                                        builder: (dynamic data,
                                            dynamic point,
                                            dynamic series,
                                            int pointIndex,
                                            int seriesIndex) {
                                          return Text('${data.value}');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Container(
                    height: 350.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total Tasks',
                                      style: TextStyles.font14BlackSemiBold,
                                    ),
                                    TextSpan(
                                      text: ' (405)',
                                      style: TextStyles.font14Primarybold,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 110.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          horizontalSpace(30),
                                          Text('All',
                                              style:
                                                  TextStyles.font12BlackSemi),
                                          horizontalSpace(30),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 130.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Chart Type: ',
                                                  style: TextStyles
                                                      .font12BlackSemi,
                                                ),
                                                TextSpan(
                                                  text: ' Line',
                                                  style:
                                                      TextStyles.font12PrimSemi,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 150.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: SizedBox.expand(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: AppColor.primaryColor,
                                            size: 16.sp,
                                          ),
                                          horizontalSpace(5),
                                          Text(
                                            'Jan - Jun 2024',
                                            style: TextStyles.font12BlackSemi,
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.primaryColor,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    _buildPopupItem('1', 'All'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('2', '1'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('3', '2'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('4', '3'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('5', '4'),
                                    const PopupMenuDivider(height: 0.5),
                                    _buildPopupItem('6', '5'),
                                  ],
                                  onSelected: (value) {},
                                  offset: Offset(0, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 61.w,
                                    maxHeight: (28.h * 4) + (0.5 * 3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10),
                          // SizedBox(
                          //   height: 220.h,
                          //   child: SfCircularChart(
                          //     legend: Legend(
                          //       isVisible: true,
                          //       position: LegendPosition.right,
                          //       overflowMode: LegendItemOverflowMode.wrap,
                          //       iconHeight: 12,
                          //       iconWidth: 12,
                          //       textStyle: TextStyles.font12BlackSemi,
                          //     ),
                          //     series: <CircularSeries>[
                          //       DoughnutSeries<ChartData, String>(
                          //         dataSource: chartDataList,
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         pointColorMapper:
                          //             (ChartData data, int index) =>
                          //                 colorMap[index],
                          //         radius: '68%',
                          //         innerRadius: '52%',
                          //         dataLabelSettings: DataLabelSettings(
                          //           isVisible: true,
                          //           labelPosition:
                          //               ChartDataLabelPosition.outside,
                          //           textStyle: TextStyles.font11BlackMedium,
                          //           connectorLineSettings:
                          //               ConnectorLineSettings(
                          //             length: '15%',
                          //             type: ConnectorType.curve,
                          //           ),
                          //         ),
                          //         explode: true,
                          //         explodeIndex: selectedIndex,
                          //         explodeGesture: ActivationMode.singleTap,
                          //         onPointTap: (ChartPointDetails details) {
                          //           setState(() {
                          //             selectedIndex =
                          //                 selectedIndex == details.pointIndex
                          //                     ? null
                          //                     : details.pointIndex;
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //     annotations: <CircularChartAnnotation>[
                          //       CircularChartAnnotation(
                          //         widget: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             if (selectedIndex != null) ...[
                          //               Text(
                          //                 '${chartDataList[selectedIndex!].value}',
                          //                 style: TextStyles.font16PrimSemiBold,
                          //               ),
                          //               Text(
                          //                 chartDataList[selectedIndex!].month,
                          //                 style: TextStyles.font12BlackSemi,
                          //               ),
                          //             ] else ...[
                          //               Text(
                          //                 'Total',
                          //                 style: TextStyles.font16PrimSemiBold,
                          //               ),
                          //               Text(
                          //                 chartDataList
                          //                     .fold(
                          //                         0,
                          //                         (sum, item) =>
                          //                             sum + item.value)
                          //                     .toString(),
                          //                 style: TextStyles.font12BlackSemi,
                          //               ),
                          //             ],
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                          // SizedBox(
                          //   height: 220.h,
                          //   child: SfCartesianChart(
                          //     legend: Legend(isVisible: false),
                          //     primaryXAxis: CategoryAxis(isVisible: false),
                          //     primaryYAxis: NumericAxis(isVisible: false),
                          //     plotAreaBorderWidth: 0,
                          //     series: <CartesianSeries>[
                          //       StackedBarSeries<ChartData, String>(
                          //         dataSource: chartDataList,
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         pointColorMapper:
                          //             (ChartData data, int index) =>
                          //                 colorMap[index],
                          //         borderWidth: 0,
                          //         borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(5.r),
                          //           bottomRight: Radius.circular(5.r),
                          //         ),
                          //         dataLabelSettings: DataLabelSettings(
                          //           isVisible: true,
                          //           labelAlignment:
                          //               ChartDataLabelAlignment.outer,
                          //           labelPosition:
                          //               ChartDataLabelPosition.inside,
                          //           builder: (dynamic data,
                          //               dynamic point,
                          //               dynamic series,
                          //               int pointIndex,
                          //               int seriesIndex) {
                          //             return Padding(
                          //               padding: EdgeInsets.only(
                          //                   left: 10, bottom: 7),
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     data.month,
                          //                     style: TextStyles
                          //                         .font11WhiteSemiBold,
                          //                   ),
                          //                   horizontalSpace(30),
                          //                   Text(
                          //                     '${data.value}%',
                          //                     style: TextStyles
                          //                         .font11WhiteSemiBold,
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //         width: 1,
                          //         spacing: 0.0,
                          //       ),
                          //     ],
                          //     tooltipBehavior: TooltipBehavior(
                          //       enable: true,
                          //       color: Colors.white,
                          //       builder: (dynamic data,
                          //           dynamic point,
                          //           dynamic series,
                          //           int pointIndex,
                          //           int seriesIndex) {
                          //         return Container(
                          //           padding: EdgeInsets.all(8),
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Text(data.month,
                          //                   style:
                          //                       TextStyles.font16PrimSemiBold),
                          //               Text('${data.value}%',
                          //                   style: TextStyles.font12BlackSemi),
                          //             ],
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // )

                          // SizedBox(
                          //   height: 220.h,
                          //   child: SfCartesianChart(
                          //     legend: Legend(isVisible: false),
                          //     primaryXAxis: CategoryAxis(isVisible: false),
                          //     primaryYAxis: NumericAxis(isVisible: false),
                          //     plotAreaBorderWidth: 0,
                          //     series: <CartesianSeries>[
                          //       StackedLineSeries<ChartData, String>(
                          //         dataSource: chartDataList,
                          //         xValueMapper: (ChartData data, _) =>
                          //             data.month,
                          //         yValueMapper: (ChartData data, _) =>
                          //             data.value,
                          //         pointColorMapper:
                          //             (ChartData data, int index) =>
                          //                 colorMap[index],
                          //         markerSettings: MarkerSettings(
                          //           isVisible: true,
                          //           shape: DataMarkerType.circle,
                          //           color: Colors.white,
                          //           borderWidth: 2,
                          //           borderColor: AppColor.primaryColor,
                          //         ),
                          //         dataLabelSettings: DataLabelSettings(
                          //           isVisible: true,
                          //           labelAlignment:
                          //               ChartDataLabelAlignment.outer,
                          //           labelPosition:
                          //               ChartDataLabelPosition.inside,
                          //           builder: (dynamic data,
                          //               dynamic point,
                          //               dynamic series,
                          //               int pointIndex,
                          //               int seriesIndex) {
                          //             return Padding(
                          //               padding: EdgeInsets.only(
                          //                   left: 10, bottom: 7),
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     data.month,
                          //                     style: TextStyles
                          //                         .font11WhiteSemiBold,
                          //                   ),
                          //                   horizontalSpace(30),
                          //                   Text(
                          //                     '${data.value}%',
                          //                     style: TextStyles
                          //                         .font11WhiteSemiBold,
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //         width: 2,
                          //       ),
                          //     ],
                          //     tooltipBehavior: TooltipBehavior(
                          //       enable: true,
                          //       color: Colors.white,
                          //       builder: (dynamic data,
                          //           dynamic point,
                          //           dynamic series,
                          //           int pointIndex,
                          //           int seriesIndex) {
                          //         return Container(
                          //           padding: EdgeInsets.all(8),
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Text(data.month,
                          //                   style:
                          //                       TextStyles.font16PrimSemiBold),
                          //               Text('${data.value}%',
                          //                   style: TextStyles.font12BlackSemi),
                          //             ],
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // )
                          SizedBox(
                            height: 220,
                            child: SfCartesianChart(
                              margin: EdgeInsets.zero,
                              primaryXAxis: CategoryAxis(
                                title: AxisTitle(text: ''),
                                majorGridLines: MajorGridLines(width: 0),
                                axisLine: AxisLine(width: 1),
                                majorTickLines: MajorTickLines(width: 0),
                                labelPlacement: LabelPlacement.onTicks,
                              ),
                              primaryYAxis: NumericAxis(
                                title: AxisTitle(text: ''),
                                minimum: 0,
                                maximum: 100,
                                interval: 20,
                                majorGridLines: MajorGridLines(
                                    width: 1, color: Colors.grey.shade200),
                                axisLine: AxisLine(width: 1),
                                majorTickLines: MajorTickLines(width: 0),
                              ),
                              plotAreaBorderWidth: 0,
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom,
                              ),
                              series: <CartesianSeries>[
                                ...List.generate(7, (index) {
                                  return SplineSeries<ChartData, String>(
                                    name: 'Series ${index + 1}',
                                    color: colorMap[index % colorMap.length],
                                    dataSource: chartDataList,
                                    xValueMapper: (ChartData data, _) =>
                                        data.month,
                                    yValueMapper: (ChartData data, _) =>
                                        data.value * (1.0 - index * 0.1),
                                    splineType: SplineType.cardinal,
                                    cardinalSplineTension: 0.8,
                                    markerSettings: MarkerSettings(
                                      isVisible: true,
                                      shape: DataMarkerType.circle,
                                      width: 10.w,
                                      height: 10.h,
                                      borderWidth: 2,
                                      borderColor: Colors.white,
                                      color: colorMap[index % colorMap.length],
                                    ),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.top,
                                      textStyle: TextStyles.font11BlackMedium,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
              ),
            );
          },
        ),
      ),
    ));
  }
}

PopupMenuItem<String> _buildPopupItem(String value, String text) {
  return PopupMenuItem(
    value: value,
    height: 28.h,
    padding: EdgeInsets.zero,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.w),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyles.font12BlackSemi,
      ),
    ),
  );
}

class ChartData {
  final String month;
  final int value;

  ChartData(this.month, this.value);
}

Widget _buildLegend(String text, Color color) {
  return Row(
    children: [
      Container(width: 8.w, height: 3.h, color: color),
      Container(
        width: 12.w,
        height: 12.h,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 2.w),
          shape: BoxShape.circle,
        ),
      ),
      Container(width: 8.w, height: 3.h, color: color),
      horizontalSpace(8),
      Text(
        text,
        style: TextStyles.font11BlackMedium,
      ),
    ],
  );
}

class FruitData {
  final String year;
  final double orange;
  final double apple;
  final double mango;
  final double grapes;

  FruitData(this.year, this.orange, this.apple, this.mango, this.grapes);
}
