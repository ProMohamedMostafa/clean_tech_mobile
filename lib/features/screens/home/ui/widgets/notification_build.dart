import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget notificationBuild() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          IconBroken.Notification,
          size: 27.sp,
          color: Colors.white,
        ),
      ),
      // if (unreadCount > 0)
      Positioned(
        right: 0,
        top: 2,
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
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
