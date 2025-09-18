import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/chart_data.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/auditor_graph/auditor_picker.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/auditor_graph/auditor_tasks_bar_chart.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditorHomeScreen extends StatefulWidget {
  const AuditorHomeScreen({super.key});

  @override
  State<AuditorHomeScreen> createState() => _AuditorHomeScreenState();
}

class _AuditorHomeScreenState extends State<AuditorHomeScreen> {
  DateTime? selectedDate;
  ChartData? selectedData;

  void _fetchData() {
    final cubit = context.read<HomeCubit>();
    if (selectedDate != null) {
      final year = selectedDate!.year;

      cubit.getAuditorTask(year: year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final isLoading =
            state is AuditorTaskLoadingState || cubit.auditorTaskData == null;

        // prepare items list dynamically from API data
        final List<Map<String, dynamic>> items = [];
        final locationData = cubit.auditorLocationCountModel?.data;

        if (locationData != null) {
          items.addAll([
            {"title": "Area", "count": locationData.countArea ?? 0},
            {"title": "City", "count": locationData.countCity ?? 0},
            {
              "title": "Organization",
              "count": locationData.countOrganization ?? 0
            },
            {"title": "Building", "count": locationData.countBuilding ?? 0},
            {"title": "Floor", "count": locationData.countFloor ?? 0},
            {"title": "Section", "count": locationData.countSection ?? 0},
          ]);
        }

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).feedback_per_month,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                verticalSpace(5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                          shape: BoxShape.rectangle),
                                    ),
                                    horizontalSpace(8),
                                    Text(
                                      S.of(context).feedback,
                                      style: TextStyles.font11BlackMedium,
                                    ),
                                  ],
                                )
                              ]),
                          horizontalSpace(8),
                          SizedBox(
                            width: 120.w,
                            child: Container(
                              height: 36.h,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  final pickedDate =
                                      await CustomAuditorYearPicker.show(
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
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          selectedDate != null
                                              ? DateFormat('yyyy')
                                                  .format(selectedDate!)
                                              : DateFormat('yyyy')
                                                  .format(DateTime.now()),
                                          style: TextStyles.font12BlackSemi,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(3),
                                    Icon(Icons.calendar_month,
                                        size: 22.sp,
                                        color: AppColor.primaryColor),
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
                        width: double.infinity,
                        child: AuditorTasksBarChart(
                            auditorTaskData: cubit.auditorTaskData),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    S.of(context).your_locations,
                    style: TextStyles.font16BlackMedium,
                  ),
                ),
              ),
              verticalSpace(10),
              ...items.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item["title"].toString(),
                          style: TextStyles.font16PrimSemiBold),
                      Text(item["count"].toString(),
                          style: TextStyles.font16PrimSemiBold),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
