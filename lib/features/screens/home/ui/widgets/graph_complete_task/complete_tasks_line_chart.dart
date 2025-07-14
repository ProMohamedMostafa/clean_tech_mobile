import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/completetion_task.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompleteTasksLineChart extends StatelessWidget {
  final CompletetionTaskModel? completeTaskData;

  const CompleteTasksLineChart({super.key, required this.completeTaskData});

  @override
  Widget build(BuildContext context) {
    if (completeTaskData == null) {
      return Loading();
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
              SplineSeries<ChartData, String>(
                dataSource: _generateChartData(
                  completeTaskData?.data?.labels,
                  completeTaskData?.data?.values,
                ),
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                splineType: SplineType.clamped,
                width: 3,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.diamond,
                  borderColor: AppColor.primaryColor,
                  color: AppColor.primaryColor,
                  height: 12.h,
                  width: 12.w,
                ),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  textStyle: TextStyles.font10lightPrimary,
                  offset: const Offset(0, 3),
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    return Text('${data.value}%',
                        style: TextStyles.font10lightPrimary);
                  },
                ),
                onCreateShader: (ShaderDetails details) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor.withOpacity(0.8),
                      AppColor.primaryColor.withOpacity(0.1),
                    ],
                  ).createShader(details.rect);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ChartData> _generateChartData(List<String>? labels, List<num>? values) {
    if (labels == null || values == null) return [];

    return List.generate(
      labels.length,
      (index) {
        final fullLabel = labels[index];
        final trimmedLabel =
            fullLabel.length >= 3 ? fullLabel.substring(0, 3) : fullLabel;
        return ChartData(trimmedLabel, values[index].toInt());
      },
    );
  }
}
