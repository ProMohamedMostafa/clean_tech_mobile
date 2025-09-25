import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/graph_feedback_overview/feedback_bar_chart.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/graph_feedback_overview/feedback_line_chart.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/graph_feedback_overview/feedback_pie_chart.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_filter_header.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackQuantityBody extends StatelessWidget {
  const FeedbackQuantityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackOverviewCubit, FeedbackOverviewState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<FeedbackOverviewCubit>();
        final isLoading = state is TotalFeedbackLoadingState ||
            cubit.totalFeedbackModel == null;

        List<(String, String)> feedbackDropdownItems = cubit
                .feedbacksModel?.data?.data
                ?.map((feedback) =>
                    (feedback.id.toString(), feedback.name ?? 'Unknown'))
                .toList() ??
            [];
        String selectedFeedbackName =
            cubit.selectedFeedbackName ?? S.of(context).all_feedbacks;
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            height: 333.h,
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
                    title: S.of(context).feedbacks_per_year,
                    chartType: cubit.selectedChartTypeFeedback,
                    dateRange: cubit.selectedDateRangeFeedback,
                    onChartTypeSelected: (value) {
                      cubit.changeChartTypeFeedback(value);
                    },
                    onDateRangeSelected: (value) {
                      cubit.changeDateRangeFeedback(value);
                    },
                    filterDropdownLabel: selectedFeedbackName,
                    filterDropdownItems: feedbackDropdownItems,
                    onFilterSelected: (value) {
                      cubit.changeSelectedFeedback(int.parse(value));
                    },
                    scrollController: cubit.feedbackScrollController,
                    showOnlyYear: true,
                  ),
                  _buildChart(context, cubit, isLoading),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(
      BuildContext context, FeedbackOverviewCubit cubit, bool isLoading) {
    final feedbackData = cubit.totalFeedbackModel?.data;

    switch (cubit.selectedChartTypeFeedback) {
      case 'Line':
      case 'خط':
      case 'لکیر':
        return FeedbackLineChart(feedbackData: feedbackData);
      case 'Bar':
      case 'شريط':
      case 'بار':
        return FeedbackBarChart(feedbackData: feedbackData);
      case 'Pie':
      case 'دائري':
      case 'پائی':
        return FeedbackPieChart(feedbackData: feedbackData);
      default:
        return FeedbackLineChart(feedbackData: feedbackData);
    }
  }
}
