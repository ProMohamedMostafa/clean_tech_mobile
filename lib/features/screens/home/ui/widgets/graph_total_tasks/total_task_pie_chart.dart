import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_status_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalTaskPieChart extends StatefulWidget {
  final TaskStatusModel? taskData;

  const TotalTaskPieChart({super.key, this.taskData});

  @override
  State<TotalTaskPieChart> createState() => _TotalTaskPieChartState();
}

class _TotalTaskPieChartState extends State<TotalTaskPieChart> {
  ChartData? selectedData;
  int? selectedIndex;

  final List<Color> colorMap = [
    Color(0xFF46B749),
    Color(0xFF3DAB64),
    Color(0xFF34A57F),
    Color(0xFF2B9F9A),
    Color(0xFF2299B5),
    Color(0xFF1894C0),
    Color(0xFF0F8FB0),
    Color(0xFF036CA3),
  ];

  // Get chart data from the taskData model
  List<ChartData> get chartDataList {
    if (widget.taskData?.data != null) {
      final List<String> labels = widget.taskData!.data!.labels ?? [];
      final List<int> values = widget.taskData!.data!.values ?? [];

      return List.generate(
        labels.length,
        (index) => ChartData(labels[index], values[index]),
      );
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: SfCircularChart(
        series: <CircularSeries>[
          RadialBarSeries<ChartData, String>(
            dataSource: chartDataList,
            xValueMapper: (ChartData data, _) => data.month.substring(0, 3),
            yValueMapper: (ChartData data, _) => data.value.toDouble(),
            pointColorMapper: (ChartData data, int index) =>
                colorMap[index % colorMap.length],
            trackColor: Colors.grey.shade300,
            maximumValue: chartDataList.isNotEmpty
                ? chartDataList
                    .map((e) => e.value)
                    .reduce((a, b) => a > b ? a : b)
                    .toDouble()
                : 100,
            radius: '110%',
            gap: '5 %',
            cornerStyle: CornerStyle.endCurve,
            trackOpacity: 0.8,
            innerRadius: '30%',
            useSeriesColor: false,
            dataLabelSettings: DataLabelSettings(isVisible: false),
            onPointTap: (ChartPointDetails details) {
              setState(() {
                selectedData = chartDataList[details.pointIndex!];
              });
            },
          ),
        ],
        legend: Legend(
          isVisible: true,
          position: LegendPosition.right,
          shouldAlwaysShowScrollbar: true,
          textStyle: TextStyles.font12BlackSemi,
        ),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedData != null ? '${selectedData!.value}' : '',
                  style: TextStyles.font14PrimRegular,
                ),
                Text(
                  selectedData?.month ?? '',
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
