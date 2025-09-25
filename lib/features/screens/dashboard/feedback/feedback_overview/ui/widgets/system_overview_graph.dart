import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/filter_location_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SystemOverviewGraph extends StatelessWidget {
  const SystemOverviewGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackOverviewCubit, FeedbackOverviewState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<FeedbackOverviewCubit>();
        final isLoading = state is FeedbackAuditLoadingState ||
            cubit.feedbackAuditModel == null;
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).system_overview,
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      horizontalSpace(8),
                      GestureDetector(
                        onTap: () {
                          cubit.clearFilter();
                          showDialog(
                            context: context,
                            builder: (dialogContext) => BlocProvider.value(
                              value: cubit..getArea(),
                              child: FilterLocationDialog(onPressed: (data) {
                                cubit.filterLocationModel = data;
                                final controllers = [
                                  cubit.areaController.text,
                                  cubit.cityController.text,
                                  cubit.organizationController.text,
                                  cubit.buildingController.text,
                                  cubit.floorController.text,
                                ];

                                final nonEmpty = controllers
                                    .where((e) => e.isNotEmpty)
                                    .toList();
                                final lastSelected =
                                    nonEmpty.isNotEmpty ? nonEmpty.last : null;
                                cubit.changeSelectedLocationGraph(
                                    lastSelected ?? "");

                                cubit.getFeedbackAuditData();
                              }),
                            ),
                          );
                        },
                        child: Container(
                          width: 90.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.r),
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Container(
                            width: 70.w,
                            height: 28.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(3.r),
                              border: Border.all(color: AppColor.primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.location_pin,
                                    size: 18.sp, color: AppColor.primaryColor),
                                horizontalSpace(8),
                                Flexible(
                                  child: Text(
                                    cubit.selectedLocationGraph ?? S.of(context).filter,
                                    style: TextStyles.font12PrimSemi,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  SizedBox(
                    height: 200.h,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<_GraphData, String>(
                          dataSource:
                              cubit.feedbackAuditModel?.data?.labels != null
                                  ? List.generate(
                                      cubit.feedbackAuditModel!.data!.labels!
                                          .length,
                                      (index) => _GraphData(
                                        cubit.feedbackAuditModel!.data!
                                            .labels![index],
                                        cubit.feedbackAuditModel!.data!
                                            .values![index],
                                        index == 0
                                            ? AppColor.primaryColor
                                            : const Color(0xFF67CF42),
                                      ),
                                    )
                                  : [],
                          xValueMapper: (_GraphData data, _) => data.label,
                          yValueMapper: (_GraphData data, _) => data.value,
                          pointColorMapper: (_GraphData data, _) => data.color,
                          dataLabelMapper: (_GraphData data, _) =>
                              data.value.toString(),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                            textStyle: TextStyles.font11WhiteSemiBold,
                          ),
                          radius: '70%',
                          explode: true,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(AppColor.primaryColor, S.of(context).feedback),
                      horizontalSpace(20),
                      _buildLegendItem(const Color(0xFF67CF42), S.of(context).audit),
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

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14.r,
          height: 7.r,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30)),
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font12BlackSemi,
        ),
      ],
    );
  }
}

class _GraphData {
  final String label;
  final int value;
  final Color color;
  _GraphData(this.label, this.value, this.color);
}
