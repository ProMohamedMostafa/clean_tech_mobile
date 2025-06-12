import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/completetion_task.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompleteTasksPieChart extends StatefulWidget {
  final CompletetionTaskModel? completeTaskData;

  const CompleteTasksPieChart({super.key, required this.completeTaskData});

  @override
  State<CompleteTasksPieChart> createState() => _CompleteTasksPieChartState();
}

class _CompleteTasksPieChartState extends State<CompleteTasksPieChart> {
  int? selectedIndex;

  List<ChartData> get chartDataList {
    // Ensure there's data in the model
    if (widget.completeTaskData!.data != null) {
      List<String> labels = widget.completeTaskData!.data!.labels ?? [];
      List<num> values = widget.completeTaskData!.data!.values ?? [];

      // Return chart data based on the available data
      return List.generate(
        labels.length,
        (index) => ChartData(labels[index], values[index]),
      );
    }

    return [];
  }

  final List<Color> colorMap = [
    Color(0xFF46B749),
    Color(0xFF44B957),
    Color(0xFF42B366),
    Color(0xFF40AF75),
    Color(0xFF3EAD84),
    Color(0xFF3CA98D),
    Color(0xFF39A197),
    Color(0xFF37A0A0),
    Color(0xFF349DA9),
    Color(0xFF3199B2),
    Color(0xFF2F96BB),
    Color(0xFF2D93C4),
    Color(0xFF036CA3),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.right,
          iconHeight: 12,
          iconWidth: 12,
          textStyle: TextStyles.font12BlackSemi,
          shouldAlwaysShowScrollbar: true,
        ),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartDataList,
            xValueMapper: (ChartData data, _) => data.month.substring(0, 3),
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, int index) => colorMap[index],
            radius: '68%',
            innerRadius: '52%',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyles.font11BlackMedium,
              connectorLineSettings: ConnectorLineSettings(
                length: '15%',
                type: ConnectorType.curve,
              ),
            ),
            explode: true,
            explodeIndex: selectedIndex,
            explodeGesture: ActivationMode.singleTap,
            onPointTap: (ChartPointDetails details) {
              setState(() {
                selectedIndex == details.pointIndex ? null : details.pointIndex;
              });
            },
          ),
        ],
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedIndex != null) ...[
                  Text(
                    '${chartDataList[selectedIndex!].value}',
                    style: TextStyles.font16PrimSemiBold,
                  ),
                  Text(
                    chartDataList[selectedIndex!].month,
                    style: TextStyles.font12BlackSemi,
                  ),
                ] else ...[
                  Text(
                    'Total',
                    style: TextStyles.font16PrimSemiBold,
                  ),
                  Text(
                    chartDataList
                        .fold(0, (sum, item) => sum + item.value.toInt())
                        .toString(),
                    style: TextStyles.font12BlackSemi,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
