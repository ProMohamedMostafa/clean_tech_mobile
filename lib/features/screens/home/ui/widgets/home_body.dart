import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  final List<ChartData> chartData = [
    ChartData('Jan', 35, 28, 40, 50),
    ChartData('Feb', 40, 35, 50, 60),
    ChartData('Mar', 45, 38, 55, 70),
    ChartData('Apr', 60, 45, 65, 80),
    ChartData('May', 55, 40, 60, 75),
    ChartData('Jun', 65, 50, 70, 90),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          homeAppBar(context),
          verticalSpace(10),
          Center(
              child: SizedBox(
                  width: double.infinity,
                  height: 300.h,
                  child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        labelRotation: -45,
                      ),
                      primaryYAxis: const NumericAxis(
                          majorTickLines: MajorTickLines(size: 2)),
                      tooltipBehavior: _tooltipBehavior,
                      // legend: const Legend(isVisible: true),
                      series: <CartesianSeries>[
                        StackedLineSeries<ChartData, String>(
                          dataSource: chartData,
                          // groupName: 'Group A',
                          // dataLabelSettings: const DataLabelSettings(
                          //     isVisible: true, useSeriesColor: true),
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1,
                          name: 'Mos3ad',
                          markerSettings: const MarkerSettings(isVisible: true),
                        ),
                      ]))),
        ],
      ),
    ));
  }
}

class ChartData {
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;

  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
}
