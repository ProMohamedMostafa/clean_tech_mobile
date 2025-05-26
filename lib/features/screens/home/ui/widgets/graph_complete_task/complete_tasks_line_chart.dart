import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/completetion_task.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompleteTasksLineChart extends StatelessWidget {
  final CompletetionTaskModel? completeTaskData;

  const CompleteTasksLineChart({super.key, required this.completeTaskData});

  @override
  Widget build(BuildContext context) {
    if (completeTaskData == null) {
      return SizedBox(
        width: double.infinity,
        height: 200.h,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: completeTaskData!.data!.labels!.length * 60,
          child: SfCartesianChart(
            borderWidth: 0,
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              majorTickLines: MajorTickLines(size: 1),
              labelRotation: 0,
              labelPlacement: LabelPlacement.betweenTicks,
              minimum: 0,
              maximum: completeTaskData!.data!.labels!.length - 1,
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
                dataSource: _generateChartData(completeTaskData?.data?.labels,
                    completeTaskData?.data?.values),
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryColor.withOpacity(0.5),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderColor: AppColor.primaryColor,
                borderWidth: 3,
                splineType: SplineType.clamped,
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  borderColor: AppColor.primaryColor,
                  color: AppColor.primaryColor,
                ),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  textStyle: TextStyles.font10lightPrimary,
                  offset: Offset(0, 3),
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    return Text('${data.value}');
                  },
                ),
              ),
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
        final fullLabel = labels[index];
        final trimmedLabel =
            fullLabel.length >= 3 ? fullLabel.substring(0, 3) : fullLabel;
        return ChartData(trimmedLabel, values[index]);
      },
    );
  }
}
