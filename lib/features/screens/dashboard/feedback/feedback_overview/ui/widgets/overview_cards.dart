import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/filter_location_dialog.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/stock_date_picker.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class OverviewCards extends StatelessWidget {
  const OverviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FeedbackOverviewCubit>();
    final isLoading = cubit.satisfactionRateModel?.data == null &&
        cubit.totalDeviceModel?.data == null &&
        cubit.totalQuestionModel?.data == null &&
        cubit.totalFeedbacksModel?.data == null;
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _OverviewCard(
                  title: S.of(context).customer_satisfaction_rate,
                  value: cubit.satisfactionRateModel?.data ?? 0,
                  icon: 'assets/images/overview1.png',
                  trailing: GestureDetector(
                    onTap: () async {
                      final selectedDate = await CustomStockMonthPicker.show(
                        context: context,
                        initialDate: cubit.selectedDate ?? DateTime.now(),
                      );
                      if (selectedDate != null) {
                        cubit.changeSelectedDate(selectedDate);
                        cubit.getSatisfactionData(month: selectedDate.month);
                      }
                    },
                    child: _CardButton(
                      icon: Icons.calendar_month,
                      label: cubit.selectedDate != null
                          ? DateFormat('MMM').format(cubit.selectedDate!)
                          : DateFormat('MMM').format(DateTime.now()),
                    ),
                  ),
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: _OverviewCard(
                  title: S.of(context).total_devices,
                  value: cubit.totalDeviceModel?.data ?? 0,
                  icon: 'assets/images/overview2.png',
                  trailing: GestureDetector(
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

                            final nonEmpty =
                                controllers.where((e) => e.isNotEmpty).toList();
                            final lastSelected =
                                nonEmpty.isNotEmpty ? nonEmpty.last : null;
                            cubit.changeSelectedLocation(lastSelected ?? "");

                            cubit.getTotalDeviceData();
                          }),
                        ),
                      );
                    },
                    child: _CardButton(
                      icon: Icons.location_pin,
                      label: cubit.selectedLocationDevices ?? S.of(context).filter,
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Expanded(
                child: _OverviewCard(
                  title: S.of(context).total_questions,
                  value: cubit.totalQuestionModel?.data ?? 0,
                  icon: 'assets/images/overview3.png',
                ),
              ),
              Expanded(
                child: _OverviewCard(
                  title: S.of(context).total_feedbacks,
                  value: cubit.totalFeedbacksModel?.data ?? 0,
                  icon: 'assets/images/overview4.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final int value;
  final String icon;
  final Widget? trailing;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(icon, height: 25.r, width: 25.r, fit: BoxFit.fill),
                horizontalSpace(4),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyles.font14BlackSemiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value.toString(),
                    style: TextStyles.font18PrimBold,
                    maxLines: 1,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CardButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 28.h,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: AppColor.primaryColor),
          horizontalSpace(8),
          Flexible(
            child: Text(
              label,
              style: TextStyles.font12PrimSemi,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
