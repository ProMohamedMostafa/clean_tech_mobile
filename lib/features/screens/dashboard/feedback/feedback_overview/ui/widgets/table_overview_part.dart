import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class BuildingsOverviewTable extends StatelessWidget {
  const BuildingsOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    final verticalController = ScrollController();
    final horizontalController = ScrollController();
    return BlocBuilder<FeedbackOverviewCubit, FeedbackOverviewState>(
      builder: (context, state) {
        final cubit = context.watch<FeedbackOverviewCubit>();
        final data = cubit.statisticsModel?.data?.data;
        final model = cubit.statisticsModel;
        final isLoading = model == null || model.data == null;

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
                children: [
                  SizedBox(
                    height: 60.h,
                    width: double.infinity,
                    child: CustomTextFormField(
                      color: AppColor.secondaryColor,
                      perfixIcon: Icon(IconBroken.search),
                      controller: cubit.searchController,
                      hint: S.of(context).find_location,
                      keyboardType: TextInputType.text,
                      onlyRead: false,
                      onChanged: (searchedCharacter) {
                        cubit.getStatisticsData();
                      },
                    ),
                  ),
                  verticalSpace(5),
                  if (data == null || data.isEmpty)
                    SizedBox(
                        height: 200,
                        child: Center(
                            child: Text(
                          S.of(context).noData,
                          style: TextStyles.font13Blackmedium,
                        )))
                  else
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 400.h),
                      child: Scrollbar(
                        controller: verticalController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: verticalController,
                          scrollDirection: Axis.vertical,
                          child: ScrollbarTheme(
                            data: ScrollbarThemeData(
                                thumbColor: WidgetStateProperty.all(
                                    AppColor.primaryColor),
                                trackVisibility: WidgetStateProperty.all(true),
                                trackColor: WidgetStateProperty.all(
                                    AppColor.fourthColor)),
                            child: Scrollbar(
                              controller: horizontalController,
                              thumbVisibility: true,
                              interactive: true,
                              thickness: 8,
                              radius: const Radius.circular(50),
                              scrollbarOrientation: ScrollbarOrientation.top,
                              child: SingleChildScrollView(
                                controller: horizontalController,
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: DataTable(
                                      headingRowColor: WidgetStateProperty.all(
                                          Colors.grey[50]),
                                      columns: [
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).buildingName)),
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).total_sensors)),
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).total_devices)),
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).total_answers)),
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).total_auditors)),
                                        DataColumn(
                                            label: _TableHeader(
                                                S.of(context).total_cleaners)),
                                        DataColumn(
                                            label: _TableHeader(S
                                                .of(context)
                                                .satisfaction_rate)),
                                      ],
                                      rows: data.map((item) {
                                        return _buildRow(
                                          item.name ?? "-",
                                          item.totalSensor ?? 0,
                                          item.totalDevice ?? 0,
                                          item.totalAnswer ?? 0,
                                          item.totalAuditor ?? 0,
                                          item.totalCleaner ?? 0,
                                          (item.rate ?? 0) / 100,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static DataRow _buildRow(
    String name,
    int sensors,
    int devices,
    int answers,
    int auditors,
    int cleaners,
    double satisfaction,
  ) {
    final bool isPositive = satisfaction >= 0.5;
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(_TableCell(text: sensors.toString())),
      DataCell(_TableCell(text: devices.toString())),
      DataCell(_TableCell(text: answers.toString())),
      DataCell(_TableCell(text: auditors.toString())),
      DataCell(_TableCell(text: cleaners.toString())),
      DataCell(
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${(satisfaction * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              horizontalSpace(4),
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 16.sp,
                color: isPositive ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  const _TableCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(child: Text(text)),
    );
  }
}
