import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/stock_date_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();

    final isLoading =
        cubit.stockTotalPriceModel == null || cubit.materialCountModel == null;

    final currentDate = DateTime.now();
    final displayDate = DateTime(
      cubit.selectedYear ?? currentDate.year,
      cubit.selectedMonth ?? currentDate.month,
    );

    final percentageChange =
        cubit.stockTotalPriceModel?.data?.percentageChange ?? 0;
    final isNegative = percentageChange < 0;

    return Skeletonizer(
      enabled: isLoading,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.pushNamed(Routes.materialScreen);
              },
              child: Container(
                height: 90.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/stock.png',
                            height: 25.h,
                            width: 25.w,
                            fit: BoxFit.fill,
                          ),
                          horizontalSpace(8),
                          Text(
                            S.of(context).materialCount,
                            style: TextStyles.font14BlackSemiBold,
                          ),
                        ],
                      ),
                      verticalSpace(8),
                      Row(
                        children: [
                          Text(
                            cubit.materialCountModel?.data?.count?.toString() ??
                                '0',
                            style: TextStyles.font18PrimBold,
                          ),
                          Expanded(child: SizedBox()),
                          Container(
                            height: 20.h,
                            width: 50.w,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(3.r),
                              border: Border.all(color: AppColor.primaryColor),
                            ),
                            child: Center(
                              child: Text(
                                cubit.materialCountModel?.data?.percentage
                                        ?.toString() ??
                                    '0',
                                style: TextStyles.font11lightPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: InkWell(
              onTap: () {
                // context.pushNamed(Routes.materialScreen);
              },
              child: Container(
                height: 90.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            color: AppColor.primaryColor,
                            size: 24.sp,
                          ),
                          horizontalSpace(2),
                          Text(
                            S.of(context).inCost,
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              final selectedDate =
                                  await CustomStockMonthPicker.show(
                                context: context,
                                initialDate: displayDate,
                              );
                              if (selectedDate != null) {
                                cubit.getStockTotalPriceCount(
                                  month: selectedDate.month,
                                  year: selectedDate.year,
                                );
                              }
                            },
                            child: Icon(
                              Icons.calendar_month,
                              size: 22.sp,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: cubit.stockTotalPriceModel?.data
                                          ?.currentMonthTotal
                                          ?.toString() ??
                                      '0',
                                  style: TextStyles.font18PrimBold,
                                ),
                                TextSpan(
                                  text: '\$',
                                  style: TextStyles.font18PrimBold,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 50.w,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isNegative
                                  ? Colors.red[100]
                                  : Colors.blue[100],
                              borderRadius: BorderRadius.circular(3.r),
                              border: Border.all(
                                color: isNegative
                                    ? Colors.red
                                    : AppColor.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    percentageChange.toString(),
                                    style: isNegative
                                        ? TextStyles.font11lightRed
                                        : TextStyles.font11lightPrimary,
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    isNegative
                                        ? Icons.trending_down_rounded
                                        : Icons.trending_up_rounded,
                                    color: isNegative
                                        ? Colors.red
                                        : AppColor.primaryColor,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
