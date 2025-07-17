import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget toggleListTile(
    VoidCallback? onPressed, String title, IconData icon, bool isSwitched) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      title,
      style: TextStyles.font14GreyRegular.copyWith(color: Colors.black),
    ),
    trailing: GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 375),
        height: 30.h,
        width: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSwitched ? Colors.grey[400] : AppColor.primaryColor,
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 375),
              curve: Curves.easeIn,
              top: 0,
              bottom: 0,
              left: isSwitched ? 23.0.w : 0.0.w,
              right: isSwitched ? 0.0.w : 23.0.w,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 375),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: isSwitched
                    ? Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                        key: const ValueKey('off'),
                      )
                    : Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        key: const ValueKey('on'),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
    dense: true,
  );
}
