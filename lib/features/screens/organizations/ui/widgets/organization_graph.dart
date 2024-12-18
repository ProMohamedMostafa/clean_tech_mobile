import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget graph(TooltipBehavior? tooltipBehavior, List<ChartData>? chartData) {
  return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: chartData!.length * 60,
          child: SfCartesianChart(
              margin: EdgeInsets.zero,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 2),
                labelRotation: 0,
                labelPlacement: LabelPlacement.onTicks,
                minimum: 0,
                maximum: chartData.length - 1,
              ),
              primaryYAxis: const NumericAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              tooltipBehavior: tooltipBehavior,
              // legend: const Legend(isVisible: true),
              series: <CartesianSeries>[
                SplineAreaSeries<ChartData, String>(
                  dataSource: chartData,
                  // groupName: 'Group A',
                  // dataLabelSettings: const DataLabelSettings(
                  //     isVisible: true, useSeriesColor: true),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryColor.withOpacity(0.8),
                      AppColor.primaryColor.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderColor: AppColor.primaryColor,
                  borderWidth: 3,
                  splineType: SplineType.clamped,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1,
                  name: 'No. of Area',
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ]),
        ),
      ));
}

class ChartData {
  final String x;
  final double y1;

  ChartData(this.x, this.y1);
}
