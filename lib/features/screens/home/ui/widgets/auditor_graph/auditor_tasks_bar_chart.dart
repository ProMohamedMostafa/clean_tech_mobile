import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/auditor_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AuditorTasksBarChart extends StatelessWidget {
  final AuditorTaskData? auditorTaskData;
  const AuditorTasksBarChart({super.key, this.auditorTaskData});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (auditorTaskData?.data?.labels?.length ?? 0) * 60,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelPlacement: LabelPlacement.betweenTicks,
              axisLine: AxisLine(width: 1.w, color: Colors.black),
              majorTickLines: const MajorTickLines(width: 0),
              labelStyle: TextStyle(color: Colors.black),
              majorGridLines: MajorGridLines(
                color: Colors.grey[200],
                width: 1.w,
              ),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 100,
              interval: 20,
              majorGridLines: MajorGridLines(
                color: Colors.grey[200],
                width: 1.w,
              ),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0),
              labelStyle: TextStyle(color: Colors.black),
            ),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                name: 'Percentage',
                dataSource: List.generate(
                  auditorTaskData?.data?.labels?.length ?? 0,
                  (index) => ChartData(
                    auditorTaskData?.data?.labels?[index] ?? '',
                    auditorTaskData?.data?.values?[index] ?? 0,
                  ),
                ),
                xValueMapper: (ChartData data, _) => data.month.substring(0, 3),
                yValueMapper: (ChartData data, _) => data.value,
                color: AppColor.primaryColor,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyles.font11Whitelight,
                  labelAlignment: ChartDataLabelAlignment.middle,
                  offset: Offset(0, 3),
                ),
                dataLabelMapper: (ChartData data, _) => '${data.value}%',
                trackColor: Color(0xffD6E9F4).withOpacity(0.7),
                trackBorderColor: Colors.transparent,
                trackPadding: 0,
                isTrackVisible: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
