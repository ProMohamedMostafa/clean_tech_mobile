import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_feedback_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FeedbackPieChart extends StatelessWidget {
  final TotalFeedbackData? feedbackData;

  const FeedbackPieChart({
    super.key,
    required this.feedbackData,
  });

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [];

    if (feedbackData != null) {
      var labels = feedbackData!.labels;
      var values = feedbackData!.valuesFeedback;

      if (labels != null && values != null) {
        for (int i = 0; i < labels.length && i < values.length; i++) {
          chartData.add(ChartData(labels[i], values[i]));
        }
      }
    }

    return SizedBox(
      height: 225.h,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelMapper: (ChartData data, _) =>
                "${data.month}: ${data.value}",
            pointColorMapper: (_, index) =>
                Colors.primaries[index % Colors.primaries.length],
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
            ),
            radius: '65%',
            explode: false,
          ),
        ],
      ),
    );
  }
}
