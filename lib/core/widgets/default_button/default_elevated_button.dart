import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String name;
  final Function? onPressed;
  final Color color;
  const DefaultElevatedButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.w,
      height: 50.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: color,
        border: Border.all(
          color: Colors.grey,
          width: 1.w,
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.all(AppColor.lightBlue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.r,
              ),
            ),
          ),
          elevation: WidgetStateProperty.all(1),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColor.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
