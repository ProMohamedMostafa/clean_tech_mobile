import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String name;
  final num height;
  final num width;
  final Function? onPressed;
  final Color color;
  final TextStyle? textStyles;
  const DefaultElevatedButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.color,
    required this.height,
    required this.width,
    required this.textStyles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: color),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(
              color: color,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(color),
          overlayColor: WidgetStateProperty.all(AppColor.thirdColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4.r,
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
        child: FittedBox(
          child: Text(
            name,
            style: textStyles,
          ),
        ),
      ),
    );
  }
}
