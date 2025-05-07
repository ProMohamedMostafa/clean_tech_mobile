import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';

Widget notificationBuild(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          IconBroken.notification,
          size: 24.sp,
          color: Colors.black,
        ),
      ),
      // if (unreadCount > 0)
      context.read<AppCubit>().isArabic()
          ? Positioned(
              left: 0,
              top: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyles.font11WhiteSemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : Positioned(
              right: 3,
              top: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyles.font11WhiteSemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
    ],
  );
}
