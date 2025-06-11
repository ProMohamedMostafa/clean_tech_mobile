import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_chart_status_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalTaskLineChart extends StatelessWidget {
  final TaskChartStatusModel? taskData;

  const TotalTaskLineChart({super.key, this.taskData});

  @override
  Widget build(BuildContext context) {
    if (taskData == null) {
      return Loading();
    }
    final List<String> labels = taskData?.data?.labels ?? [];
    final List<int> values = taskData?.data?.values ?? [];

    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: labels.length * 60.w,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 1),
              majorTickLines: const MajorTickLines(width: 0),
              labelPlacement: LabelPlacement.betweenTicks,
              axisLabelFormatter: (AxisLabelRenderDetails details) {
                final String originalLabel = details.text;
                final String trimmedLabel = originalLabel.length > 4
                    ? originalLabel.substring(0, 4)
                    : originalLabel;
                return ChartAxisLabel(trimmedLabel, details.textStyle);
              },
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: ''),
              minimum: 0,
              maximum: values.isNotEmpty
                  ? values.reduce((a, b) => a > b ? a : b).toDouble() * 1.2
                  : 100,
              interval: 20,
              majorGridLines:
                  MajorGridLines(width: 1.w, color: Colors.grey.shade200),
              axisLine: AxisLine(width: 1.w),
            ),
            plotAreaBorderWidth: 0,
            tooltipBehavior: TooltipBehavior(
              color: Colors.white,
              enable: true,
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
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
            series: <CartesianSeries>[
              ...List.generate(
                labels.length,
                (index) {
                  return SplineSeries<ChartData, String>(
                    name: labels[index],
                    color: AppColor.primaryColor,
                    width: 2.w,
                    dataSource: _generateChartData(
                        taskData?.data?.labels, taskData?.data?.values),
                    xValueMapper: (ChartData data, _) => data.month,
                    yValueMapper: (ChartData data, _) => data.value.toDouble(),
                    splineType: SplineType.cardinal,
                    cardinalSplineTension: 0.8,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      width: 12.w,
                      height: 12.h,
                      borderWidth: 2.w,
                      borderColor: Colors.white,
                      color: AppColor.primaryColor,
                    ),
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                      textStyle: TextStyles.font12PrimSemi,
                      builder: (dynamic data, _, __, ___, ____) {
                        return Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            data.value.toString(),
                            style: TextStyles.font11WhiteSemiBold,
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<ChartData> _generateChartData(List<String>? labels, List<int>? values) {
    if (labels == null || values == null) return [];

    return List.generate(
      labels.length,
      (index) {
        final label = labels[index];
        final trimmed = label.length > 4 ? label.substring(0, 4) : label;
        return ChartData(trimmed, values[index]);
      },
    );
  }
}
