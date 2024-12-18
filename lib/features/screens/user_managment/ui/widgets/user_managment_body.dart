import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UserManagmentBody extends StatefulWidget {
  const UserManagmentBody({super.key});

  @override
  State<UserManagmentBody> createState() => _UserManagmentBodyState();
}

class _UserManagmentBodyState extends State<UserManagmentBody> {
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 150,
                      height: 120,
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            startAngle: 270,
                            endAngle: 270,
                            showLabels: false,
                            showTicks: false,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.1,
                              cornerStyle: CornerStyle.bothCurve,
                              color: const Color.fromRGBO(36, 124, 255, 1),
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                positionFactor: 1.5,
                                angle: 270,
                                widget: Text(
                                  'Total Users\n30',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                              ),
                              GaugeAnnotation(
                                positionFactor: 0,
                                widget: Text(
                                  '${((30 / 100) * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: 100,
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                gradient: const SweepGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(36, 124, 255, 1),
                                    Color.fromRGBO(182, 186, 241, 1)
                                  ],
                                  stops: <double>[0.25, 0.75],
                                ),
                              ),
                              MarkerPointer(
                                enableAnimation: true,
                                value: 30,
                                markerType: MarkerType.circle,
                                color: AppColor.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 150,
                      height: 120,
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.1,
                              cornerStyle: CornerStyle.bothCurve,
                              color: const Color.fromARGB(255, 0, 169, 181),
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                positionFactor: 1.5,
                                angle: 270,
                                widget: Text(
                                  'Total Users\n60',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                              ),
                              GaugeAnnotation(
                                positionFactor: 0,
                                widget: Text(
                                  '${((60 / 100) * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                            pointers: <GaugePointer>[
                              // RangePointer for the grey 40% segment
                              RangePointer(
                                value: 40, // Represents 40% of the total scale
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                color: Colors
                                    .grey, // Grey color for the 40% segment
                              ),
                              // RangePointer for the remaining portion (after 40%)
                              RangePointer(
                                value: 100, // Represents 100% of the scale
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                gradient: const SweepGradient(
                                  colors: <Color>[
                                    Color(0xFF00a9b5),
                                    Color(0xFFa4edeb),
                                  ],
                                  stops: <double>[0.25, 0.75],
                                ),
                              ),
                              // MarkerPointer for the value of 600
                              MarkerPointer(
                                enableAnimation: true,
                                value:
                                    60, // Current value (percentage scale 0-100)
                                markerType: MarkerType.circle,
                                color: AppColor.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(30),
              SizedBox(
                height: 40.h,
                width: 110.w,
                child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(Routes.addUserScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: REdgeInsets.all(0),
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: BorderSide(
                        color: AppColor.secondaryColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        horizontalSpace(3),
                        Text(
                          S.of(context).addUserButton,
                          style: TextStyles.font13Whitemedium,
                        ),
                      ],
                    )),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 45.w,
                      height: 45.h,
                    ),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Mosad Selim',
                        style: TextStyles.font14Primarybold,
                      ),
                      Text(
                        'mossad.selim11@gmail.com',
                        style: TextStyles.font12GreyRegular,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText10,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '(684) 555-0102',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText7,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '(684) 555-0102',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText4,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '28-4-1990',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText8,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Egyption',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText9,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Male',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showCustomDialog(context, S.of(context).deleteMessage);
                      },
                      icon: Icon(
                        IconBroken.delete,
                        color: AppColor.primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        context.pushNamed(Routes.editUserScreen);
                      },
                      icon: Icon(
                        Icons.mode_edit_outlined,
                        color: AppColor.primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        context.pushNamed(Routes.userDetailsScreen);
                      },
                      icon: Icon(
                        Icons.edit_note_sharp,
                        color: AppColor.primaryColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
