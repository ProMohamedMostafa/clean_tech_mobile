import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';

class NotificationBuild extends StatelessWidget {
  const NotificationBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        final unreadCount =
            context.watch<AppCubit>().notificationModel?.data?.data?.length ??
                0;

        return Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                IconBroken.notification,
                size: 24.sp,
                color: AppColor.primaryColor,
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                right: cubit.isArabic() ? null : 3,
                left: cubit.isArabic() ? 0 : null,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14.w,
                    minHeight: 14.h,
                  ),
                  child: Center(
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyles.font11WhiteSemiBold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
