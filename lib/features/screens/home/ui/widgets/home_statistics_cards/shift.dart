import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class Shift extends StatelessWidget {
  const Shift({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    final model = cubit.shiftsCountModel;
    final isLoading = model == null || model.data == null;

    final activePercentage = model?.data?.activePercentage ?? 0;
    final totalCount = model?.data?.totalCount ?? 0;
    final inactiveCount = model?.data?.inactiveCount ?? 0;
    final activeCount = model?.data?.activeCount ?? 0;

    return Skeletonizer(
      enabled: isLoading,
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.shiftScreen);
        },
        child: Container(
          height: 95.h,
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
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_rounded,
                      color: AppColor.primaryColor,
                      size: 24.sp,
                    ),
                    horizontalSpace(8),
                    Text(
                      S.of(context).totalShifts,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    const Spacer(),
                    Container(
                      height: 20.h,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(3.r),
                        border: Border.all(color: AppColor.primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          '${activePercentage.toStringAsFixed(2)} %',
                          style: TextStyles.font11lightPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '$totalCount',
                      style: TextStyles.font18PrimBold,
                    ),
                    Spacer(),
                    _statusBox(
                      color: AppColor.primaryColor,
                      text: '${S.of(context).active} $activeCount',
                      iconColor: AppColor.primaryColor,
                      onTap: () {
                        context.pushNamed(
                          Routes.shiftScreen,
                          arguments: 'true',
                        );
                      },
                    ),
                    horizontalSpace(10),
                    _statusBox(
                      color: Colors.redAccent,
                      text: '${S.of(context).inactive} $inactiveCount',
                      iconColor: Colors.redAccent,
                      onTap: () {
                        context.pushNamed(
                          Routes.shiftScreen,
                          arguments: 'false',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBox({
    required Color color,
    required String text,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            horizontalSpace(8),
            Text(
              text,
              style: TextStyles.font11BlackMedium,
            ),
            horizontalSpace(8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
