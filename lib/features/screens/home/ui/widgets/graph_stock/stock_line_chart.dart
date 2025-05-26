import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/total_stock.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockLineChart extends StatelessWidget {
  final TotalStockData? stockData;

  const StockLineChart({super.key, required this.stockData});

  @override
  Widget build(BuildContext context) {
    if (stockData == null) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: stockData!.labels!.length * 60,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelPlacement: LabelPlacement.betweenTicks,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: AxisLine(width: 1, color: Colors.grey[200]),
              majorTickLines: const MajorTickLines(width: 0),
              labelStyle: TextStyle(color: Colors.black),
              labelRotation: -45,
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 200,
              interval: 50,
              majorGridLines: MajorGridLines(
                color: Colors.grey[200],
                width: 0.8,
              ),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0),
              labelStyle: TextStyle(color: Colors.black),
            ),
            series: <CartesianSeries>[
              SplineSeries<ChartData, String>(
                name: 'In',
                dataSource: _generateChartData(
                    stockData?.labels, stockData?.valuesStockIn),
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                color: AppColor.primaryColor,
                splineType: SplineType.cardinal,
                cardinalSplineTension: 0.8,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  borderWidth: 2,
                  borderColor: Colors.white,
                  color: AppColor.primaryColor,
                  width: 10,
                  height: 10,
                ),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  labelAlignment: ChartDataLabelAlignment.top,
                  offset: Offset(0, 6),
                ),
              ),
              SplineSeries<ChartData, String>(
                name: 'Out',
                dataSource: _generateChartData(
                    stockData?.labels, stockData?.valuesStockOut),
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                color: const Color(0xff46B749),
                splineType: SplineType.cardinal,
                cardinalSplineTension: 0.8,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  borderWidth: 2,
                  borderColor: Colors.white,
                  shape: DataMarkerType.circle,
                  color: const Color(0xff46B749),
                  width: 10,
                  height: 10,
                ),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    color: const Color(0xff46B749),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  labelAlignment: ChartDataLabelAlignment.bottom,
                  offset: Offset(0, 6),
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
