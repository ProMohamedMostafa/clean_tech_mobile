import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/build_legend.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_pie_chart.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

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
                .providersModel?.data?.data
                ?.map((provider) =>
                    (provider.id.toString(), provider.name ?? 'Unknown'))
                .toList() ??
            [];
        String selectedProviderName =
            cubit.selectedProviderName ?? S.of(context).All_Providers;
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            height: 340.h,
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
                    title: S.of(context).stockQuantity,
                    chartType: cubit.selectedChartTypeProvider,
                    dateRange: cubit.selectedDateRangeProvider,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeStock(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeProvider(value);
                    },
                    filterDropdownLabel: selectedProviderName,
                    filterDropdownItems: providerDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedProvider(int.parse(value));
                    },
                    scrollController: cubit.providerScrollController,
                    showOnlyYear: true,
                  ),
                  _buildChart(context, cubit, isLoading),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildLegend(S.of(context).inSide, AppColor.primaryColor),
                      Text(
                        ' $totalIn',
                        style: TextStyles.font14PrimRegular,
                      ),
                      horizontalSpace(16),
                      buildLegend(
                          S.of(context).outSide, const Color(0xff46B749)),
                      Text(
                        ' $totalOut',
                        style: TextStyles.font14PrimRegular
                            .copyWith(color: const Color(0xff46B749)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(BuildContext context, HomeCubit cubit, bool isLoading) {
    final stockData = cubit.totalStockModel?.data;

    switch (cubit.selectedChartTypeProvider) {
      case 'Line':
      case 'خط':
      case 'لکیر':
        return StockLineChart(stockData: stockData);
      case 'Bar':
      case 'شريط':
      case 'بار':
        return StockBarChart(stockData: stockData);
      case 'Pie':
      case 'دائري':
      case 'پائی':
        return StockPieChart(stockData: stockData);
      default:
        return StockLineChart(stockData: stockData);
    }
  }
}
