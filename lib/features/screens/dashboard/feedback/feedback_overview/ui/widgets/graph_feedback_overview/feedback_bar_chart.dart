import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_feedback_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FeedbackBarChart extends StatelessWidget {
  final TotalFeedbackData? feedbackData;

  const FeedbackBarChart({super.key, required this.feedbackData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 225.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: feedbackData!.labels!.length * 60,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelPlacement: LabelPlacement.betweenTicks,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: AxisLine(width: 1, color: Colors.grey[200]),
              majorTickLines: const MajorTickLines(width: 0),
              labelStyle: TextStyle(color: Colors.black),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
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
              ColumnSeries<ChartData, String>(
                name: 'feedback',
                dataSource: List.generate(
                  feedbackData?.labels?.length ?? 0,
                  (index) => ChartData(
                    feedbackData?.labels?[index] ?? '',
                    feedbackData?.valuesFeedback?[index] ?? 0,
                  ),
                ),
                xValueMapper: (ChartData data, _) => data.month.length > 3
                    ? data.month.substring(0, 3)
                    : data.month,
                yValueMapper: (ChartData data, _) => data.value,
                color: const Color(0xff46B749),
                width: 0.6,
                spacing: 0.2,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.outer,
                  textStyle: TextStyles.font10lightPrimary
                      .copyWith(color: Color(0xff46B749)),
                ),
              ),
            ],
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              format: 'point.x : point.y',
            ),
          ),
        ),
      ),
    );
  }
}
