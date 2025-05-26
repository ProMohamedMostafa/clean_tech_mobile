import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_status_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalTaskBarChart extends StatelessWidget {
  final TaskStatusModel? taskData;

  const TotalTaskBarChart({super.key, required this.taskData});

  @override
  Widget build(BuildContext context) {
    final labels = taskData?.data?.labels ?? [];
    final values = taskData?.data?.values ?? [];

    final List<ChartData> chartDataList = List.generate(
      labels.length,
      (index) => ChartData(labels[index], values[index]),
    );

    final List<Color> colorMap = [
      AppColor.primaryColor,
      const Color(0xFF127E9D),
      const Color(0xFF219097),
      const Color(0xFF1BA59B),
      const Color(0xFF30A291),
      const Color(0xFF3BB48B),
      const Color(0xff46B749),
    ];

    return SizedBox(
      height: 200.h,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          isVisible: true,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: TextStyles.font12BlackSemi,
          labelPlacement: LabelPlacement.betweenTicks,
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        legend: Legend(isVisible: false),
        series: <CartesianSeries>[
          StackedBarSeries<ChartData, String>(
            dataSource: chartDataList,
            xValueMapper: (ChartData data, _) => data.month.substring(0, 4),
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, int index) =>
                colorMap[index % colorMap.length],
            borderWidth: 0,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            dataLabelSettings: DataLabelSettings(
              margin: EdgeInsets.zero,
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
              labelPosition: ChartDataLabelPosition.inside,
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                return Text(data.value.toString(),
                    style: TextStyles.font11WhiteSemiBold);
              },
            ),
            width: 0.85.w,
            spacing: 0.0,
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          color: Colors.white,
          enable: true,
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(data.month, style: TextStyles.font16PrimSemiBold),
                  Text(data.value.toString(),
                      style: TextStyles.font12BlackSemi),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
