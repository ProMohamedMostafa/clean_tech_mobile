import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_sensor/sensor_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_sensor/sensor_tile.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorTasksRateBody extends StatefulWidget {
  const SensorTasksRateBody({super.key});

  @override
  State<SensorTasksRateBody> createState() => _SensorTasksRateBodyState();
}

class _SensorTasksRateBodyState extends State<SensorTasksRateBody> {
  DateTime? selectedDate;
  ChartData? selectedData;
  final List<Color> colorMap = [
    Color(0xFF00B4D8),
    Color(0xFFFF006E),
    AppColor.primaryColor,
    Color(0xFF8338EC),
  ];
  int selectedIndex = 2;
  String selectedKey = '';
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    final cubit = context.read<HomeCubit>();
    cubit.getSection();
    cubit.getChartSensorData();

    // Initialize the selected label/value with default data if available:
    final status = cubit.sensorChartModel?.data?.status;
    if (status != null) {
      selectedKey = S.current.Total_completed_sensors_tasks;
      selectedValue =
          '${cubit.sensorChartModel?.data?.totalCompletionPercentage ?? 0}%';
    }
  }

  void _fetchData() {
    final cubit = context.read<HomeCubit>();
    if (cubit.selectedSectionId != null) {
      cubit.getChartSensorData(
        month: selectedDate!.month,
        year: selectedDate!.year,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final status = cubit.sensorChartModel?.data?.status;
        final sensorCount =
            cubit.sensorChartModel?.data?.getCompletionDeviceTask?.length ?? 0;

        final List<ChartData> chartDataList = [
          ChartData('Pending', status?.pendingPercentage ?? 0),
          ChartData('In Progress', status?.inProgressPercentage ?? 0),
          ChartData('Completed', status?.completedPercentage ?? 0),
          ChartData('Overdue', status?.overduePercentage ?? 0),
        ];
        // Initialize selectedKey and selectedValue at build if empty (to show default)
        if (selectedKey.isEmpty && status != null) {
          selectedKey = S.current.Total_completed_sensors_tasks;
          selectedValue =
              '${cubit.sensorChartModel?.data?.totalCompletionPercentage ?? 0}%';
        }
        final isLoading =
            state is HomeLoadingState || cubit.sensorChartModel == null;
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).Sensors_Task_Completion_Rates,
                    style: TextStyles.font14BlackSemiBold,
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Section Dropdown
                      if (cubit.sectionBasicModel?.data != null)
                        _FilterDropdown(
                          width: 150.w,
                          label: cubit.selectedSectionName ??
                              S.of(context).Select_section,
                          items: cubit.sectionBasicModel!.data!
                              .map((section) => (
                                    section.id.toString(),
                                    section.name ?? 'Unknown',
                                  ))
                              .toList(),
                          onSelected: (value) {
                            final selected = cubit.sectionBasicModel!.data!
                                .firstWhere((s) => s.name == value);
                            setState(() {
                              cubit.selectedSectionId = selected.id.toString();
                              cubit.selectedSectionName = selected.name;
                              _fetchData();
                            });
                          },
                        ),
                      horizontalSpace(8),
                      // Date Picker
                      Container(
                        height: 36.h,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final pickedDate =
                                await CustomSensorMonthPicker.show(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                                selectedData = null;
                              });
                              _fetchData();
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                selectedDate != null
                                    ? DateFormat('MMMM yyyy')
                                        .format(selectedDate!)
                                    : DateFormat('MMMM yyyy')
                                        .format(DateTime.now()),
                                style: TextStyles.font14BlackRegular,
                              ),
                              horizontalSpace(3),
                              Icon(Icons.calendar_month,
                                  size: 22.sp, color: AppColor.primaryColor),
                            ],
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
                        PieSeries<ChartData, String>(
                          dataSource: chartDataList,
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) =>
                              data.value.toDouble(),
                          pointColorMapper: (ChartData data, int index) =>
                              colorMap[index % colorMap.length],
                          pointRadiusMapper: (ChartData data, _) =>
                              '${70 + (data.value % 30)}%',
                          radius: '80%',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          dataLabelMapper: (ChartData data, _) =>
                              '${data.value}%',
                          enableTooltip: true,
                          selectionBehavior: SelectionBehavior(
                            enable: true,
                            selectedColor: null,
                            unselectedColor: null,
                            selectedOpacity: 1.0,
                            unselectedOpacity: 1.0,
                            toggleSelection: true,
                          ),
                        ),
                      ],
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.right,
                        shouldAlwaysShowScrollbar: true,
                        textStyle: TextStyles.font12BlackSemi,
                      ),
                      onSelectionChanged: (SelectionArgs args) {
                        final index = args.pointIndex;
                        final selected = chartDataList[index];

                        setState(() {
                          selectedIndex = index;

                          switch (selected.month) {
                            case 'Pending':
                              selectedKey =
                                  S.current.Total_pending_sensors_tasks;
                              break;
                            case 'In Progress':
                              selectedKey =
                                  S.current.Total_inProgress_sensors_tasks;
                              break;
                            case 'Completed':
                              selectedKey =
                                  S.current.Total_completed_sensors_tasks;
                              break;
                            case 'Overdue':
                              selectedKey =
                                  S.current.Total_overdue_sensors_tasks;
                              break;
                            default:
                              selectedKey = selected.month;
                          }
                          selectedValue = '${selected.value}%';
                        });
                      },
                    ),
                  ),
                  verticalSpace(10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: AppColor.fourthColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedKey),
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: colorMap[selectedIndex % colorMap.length],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Text(
                                selectedValue,
                                style: TextStyles.font13WhiteRegular,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).Sensors),
                        Text(S.of(context).battery),
                        Text(S.of(context).tasks),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: sensorCount > 5
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      itemCount: sensorCount,
                      itemBuilder: (context, index) {
                        final sensor = cubit.sensorChartModel!.data!
                            .getCompletionDeviceTask![index];
                        return InkWell(
                          onTap: () {
                            context.pushNamed(Routes.sensorDetailsScreen,
                                arguments: sensor.id);
                          },
                          child: SizedBox(
                            height: 40,
                            child: SensorTile(
                              name: sensor.name ?? 'Unknown',
                              battery: sensor.battery ?? 0,
                              tasks:
                                  (sensor.completionPercentage ?? 0).toDouble(),
                              isOnline: (sensor.battery ?? 0) > 50,
                            ),
                          ),
                        );
                      },
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
}

// _FilterDropdown class remains the same as in your original code

class _FilterDropdown extends StatelessWidget {
  final double? width;
  final String label;

  final List<(String, String)> items;
  final ValueChanged<String>? onSelected;

  const _FilterDropdown({
    this.width,
    required this.label,
    required this.items,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 36.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        color: Colors.white,
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyles.font12PrimSemi,
                overflow: TextOverflow.ellipsis,
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.primaryColor,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
        menuPadding: EdgeInsets.zero,
        itemBuilder: (context) => [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) PopupMenuDivider(height: 0.5.h),
            PopupMenuItem<String>(
              value: items[i].$1,
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                items[i].$2,
                style: TextStyles.font12BlackSemi,
              ),
            ),
          ],
        ],
        onSelected: (value) {
          // Find and return the display text
          final selectedItem = items.firstWhere((item) => item.$1 == value);
          onSelected?.call(selectedItem.$2);
        },
        offset: Offset(0, 36.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        constraints: BoxConstraints(
          minWidth: width!,
          maxHeight: 140.h,
        ),
      ),
    );
  }
}
