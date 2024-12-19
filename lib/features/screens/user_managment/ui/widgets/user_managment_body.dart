import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/addin_search_build.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/data_view_build.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/graph_user_management.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/user_details_build.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserManagmentBody extends StatefulWidget {
  const UserManagmentBody({super.key});

  @override
  State<UserManagmentBody> createState() => _UserManagmentBodyState();
}

class _UserManagmentBodyState extends State<UserManagmentBody> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  final List<ChartData> chartData = [
    ChartData('NasrCity', 3, 4),
    ChartData('Future', 5, 6),
    ChartData('Hegaz', 6, 8),
    ChartData('Tagmoa', 5, 7),
    ChartData('Sherok', 2, 3),
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
              verticalSpace(10),
              dataViewBuild(),
              verticalSpace(20),
              Text("User management overview",
                  style: TextStyles.font18PrimBold),
              verticalSpace(20),
              graphUserManagement(_tooltipBehavior, chartData),
              verticalSpace(20),
              Text("Adding user", style: TextStyles.font18PrimBold),
              verticalSpace(20),
              addingAndSearchBuild(
                  context, context.read<UserManagementCubit>()),
              verticalSpace(20),
              userDetailsBuild(context)
            ],
          ),
        ),
      )),
    );
  }

  
}





// Expanded(
//                     child: SizedBox(
//                       width: 150,
//                       height: 120,
//                       child: SfRadialGauge(
//                         axes: <RadialAxis>[
//                           RadialAxis(
//                             startAngle: 270,
//                             endAngle: 270,
//                             showLabels: false,
//                             showTicks: false,
//                             axisLineStyle: AxisLineStyle(
//                               thickness: 0.1,
//                               cornerStyle: CornerStyle.bothCurve,
//                               color: const Color.fromRGBO(36, 124, 255, 1),
//                               thicknessUnit: GaugeSizeUnit.factor,
//                             ),
//                             annotations: <GaugeAnnotation>[
//                               GaugeAnnotation(
//                                 positionFactor: 1.5,
//                                 angle: 270,
//                                 widget: Text(
//                                   'Total Users\n30',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontSize: 11.sp),
//                                 ),
//                               ),
//                               GaugeAnnotation(
//                                 positionFactor: 0,
//                                 widget: Text(
//                                   '${((30 / 100) * 100).toStringAsFixed(1)}%',
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             pointers: <GaugePointer>[
//                               RangePointer(
//                                 value: 100,
//                                 width: 0.1,
//                                 sizeUnit: GaugeSizeUnit.factor,
//                                 cornerStyle: CornerStyle.startCurve,
//                                 gradient: const SweepGradient(
//                                   colors: <Color>[
//                                     Color.fromRGBO(36, 124, 255, 1),
//                                     Color.fromRGBO(182, 186, 241, 1)
//                                   ],
//                                   stops: <double>[0.25, 0.75],
//                                 ),
//                               ),
//                               MarkerPointer(
//                                 enableAnimation: true,
//                                 value: 30,
//                                 markerType: MarkerType.circle,
//                                 color: AppColor.primaryColor,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       width: 150,
//                       height: 120,
//                       child: SfRadialGauge(
//                         axes: <RadialAxis>[
//                           RadialAxis(
//                             minimum: 0,
//                             maximum: 100,
//                             showLabels: false,
//                             showTicks: false,
//                             startAngle: 270,
//                             endAngle: 270,
//                             axisLineStyle: AxisLineStyle(
//                               thickness: 0.1,
//                               cornerStyle: CornerStyle.bothCurve,
//                               color: const Color.fromARGB(255, 0, 169, 181),
//                               thicknessUnit: GaugeSizeUnit.factor,
//                             ),
//                             annotations: <GaugeAnnotation>[
//                               GaugeAnnotation(
//                                 positionFactor: 1.5,
//                                 angle: 270,
//                                 widget: Text(
//                                   'Total Users\n60',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontSize: 11.sp),
//                                 ),
//                               ),
//                               GaugeAnnotation(
//                                 positionFactor: 0,
//                                 widget: Text(
//                                   '${((60 / 100) * 100).toStringAsFixed(1)}%',
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             pointers: <GaugePointer>[
//                               // RangePointer for the grey 40% segment
//                               RangePointer(
//                                 value: 40, // Represents 40% of the total scale
//                                 width: 0.1,
//                                 sizeUnit: GaugeSizeUnit.factor,
//                                 cornerStyle: CornerStyle.startCurve,
//                                 color: Colors
//                                     .grey, // Grey color for the 40% segment
//                               ),
//                               // RangePointer for the remaining portion (after 40%)
//                               RangePointer(
//                                 value: 100, // Represents 100% of the scale
//                                 width: 0.1,
//                                 sizeUnit: GaugeSizeUnit.factor,
//                                 cornerStyle: CornerStyle.startCurve,
//                                 gradient: const SweepGradient(
//                                   colors: <Color>[
//                                     Color(0xFF00a9b5),
//                                     Color(0xFFa4edeb),
//                                   ],
//                                   stops: <double>[0.25, 0.75],
//                                 ),
//                               ),
//                               // MarkerPointer for the value of 600
//                               MarkerPointer(
//                                 enableAnimation: true,
//                                 value:
//                                     60, // Current value (percentage scale 0-100)
//                                 markerType: MarkerType.circle,
//                                 color: AppColor.primaryColor,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                