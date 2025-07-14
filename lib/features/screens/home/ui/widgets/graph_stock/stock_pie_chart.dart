import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/total_stock.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockPieChart extends StatelessWidget {
  final TotalStockData? stockData;

  const StockPieChart({
    super.key,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [];

    if (stockData != null) {
      var labels = stockData!.labels;
      var valuesStockIn = stockData!.valuesStockIn;
      var valuesStockOut = stockData!.valuesStockOut;

      if (labels != null && valuesStockIn != null && valuesStockOut != null) {
        int totalIn = valuesStockIn.reduce((a, b) => a + b);
        int totalOut = valuesStockOut.reduce((a, b) => a + b);

        chartData = [
          ChartData('Stock In', totalIn),
          ChartData('Stock Out', totalOut),
        ];
      }
    }

    return SizedBox(
      height: 225.h,
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.month == 'Stock In'
                ? AppColor.primaryColor
                : const Color(0xff46B749),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              connectorLineSettings: ConnectorLineSettings(
                length: '20%',
                type: ConnectorType.curve,
              ),
            ),
            radius: '90%',
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
          ),
        ],
      ),
    );
  }
}
