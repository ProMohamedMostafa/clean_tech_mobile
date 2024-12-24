
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
                