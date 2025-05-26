import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/build_legend.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_pie_chart.dart';

import 'package:skeletonizer/skeletonizer.dart';

class StockQuantityBody extends StatelessWidget {
  const StockQuantityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<HomeCubit>();
        final isLoading =
            state is TotalStockLoadingState || cubit.totalStockModel == null;

        final totalIn = cubit.totalStockModel?.data?.valuesStockIn
                ?.fold<int>(0, (a, b) => a + b) ??
            0;
        final totalOut = cubit.totalStockModel?.data?.valuesStockOut
                ?.fold<int>(0, (a, b) => a + b) ??
            0;
        List<(String, String)> providerDropdownItems = cubit
                .providersModel?.data?.providers
                ?.map((provider) =>
                    (provider.id.toString(), provider.name ?? 'Unknown'))
                .toList() ??
            [];

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterHeader(
                    title: 'Stock Quantity',
                    count1: totalIn,
                    count2: totalOut,
                    chartType: cubit.selectedChartTypeProvider,
                    dateRange: cubit.selectedDateRangeProvider,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeStock(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeProvider(value);
                    },
                    filterDropdownLabel: cubit.selectedProviderName,
                    filterDropdownItems: providerDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedProvider(int.parse(value));
                    },
                    scrollController: cubit.providerScrollController,
                  ),
                  _buildChart(cubit, isLoading),
                  _buildLegends(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(HomeCubit cubit, bool isLoading) {
    final stockData = cubit.totalStockModel?.data;

    switch (cubit.selectedChartTypeProvider) {
      case 'Line':
        return StockLineChart(stockData: stockData);
      case 'Bar':
        return StockBarChart(stockData: stockData);
      case 'Pie':
        return StockPieChart(stockData: stockData);
      default:
        return StockLineChart(stockData: stockData);
    }
  }

  Widget _buildLegends() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildLegend('In side', AppColor.primaryColor),
        horizontalSpace(16),
        buildLegend('Out side', const Color(0xff46B749)),
      ],
    );
  }
}
