import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget graphUserManagement(
    TooltipBehavior? tooltipBehavior, List<ChartData>? chartData) {
  return SizedBox(
      width: double.infinity,
      height: 250.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: chartData!.length * 70,
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            borderWidth: 0,
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              majorTickLines: MajorTickLines(size: 1),
              labelRotation: 0,
              interval: 1,
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: MajorGridLines(
                width: 0.5,
                color: Colors.grey.withOpacity(0.3),
              ),
              axisLine: AxisLine(width: 0),
              interval: 1,
            ),
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y1,
                name: 'Floors',
                color: const Color(0xFF00a9b5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                dataLabelSettings: DataLabelSettings(
                  margin: EdgeInsets.zero,
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.middle,
                  textStyle: TextStyles.font11Whitelight,
                  angle: -90,
                ),
                dataLabelMapper: (ChartData data, _) => 'Floors',
              ),
              ColumnSeries<ChartData, String>(
                width: 0.7,
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y2,
                name: 'Employees',
                color: const Color(0xFFEAAC7F),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                dataLabelSettings: DataLabelSettings(
                  margin: EdgeInsets.zero,
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.middle,
                  textStyle: TextStyles.font11Whitelight,
                  angle: -90,
                ),
                dataLabelMapper: (ChartData data, _) => 'Employees',
              ),
            ],
          ),
        ),
      ));
}

class ChartData {
  final String x;
  final double y1;
  final double y2;

  ChartData(this.x, this.y1, this.y2);
}
