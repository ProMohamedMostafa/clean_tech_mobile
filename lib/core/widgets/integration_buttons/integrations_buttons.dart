import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget integrationsButtons({
  required int selectedIndex,
  required Function(int index) onTap,
  int? firstCount,
  required String firstLabel,
  int? secondCount,
  String? secondLabel,
  int? thirdCount,
  String? thirdLabel,
  int? fourthCount,
  String? fourthLabel,
}) {
  return Row(
    children: [
      _buildButton(
        index: 0,
        selectedIndex: selectedIndex,
        count: firstCount,
        label: firstLabel,
        onTap: onTap,
      ),
      if (secondCount != null || secondLabel != null) ...[
        horizontalSpace(10),
        _buildButton(
          index: 1,
          selectedIndex: selectedIndex,
          count: secondCount,
          label: secondLabel!,
          onTap: onTap,
        )
      ],
      if (thirdCount != null || thirdLabel != null) ...[
        horizontalSpace(10),
        _buildButton(
          index: 2,
          selectedIndex: selectedIndex,
          count: thirdCount,
          label: thirdLabel!,
          onTap: onTap,
        ),
      ],
      if (fourthCount != null || fourthLabel != null) ...[
        horizontalSpace(10),
        _buildButton(
          index: 3,
          selectedIndex: selectedIndex,
          count: fourthCount,
          label: fourthLabel!,
          onTap: onTap,
        ),
      ]
    ],
  );
}

Widget _buildButton({
  required int index,
  required int selectedIndex,
  int? count,
  required String label,
  required Function(int) onTap,
}) {
  final bool isSelected = selectedIndex == index;

  return Expanded(
    child: GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColor.secondaryColor,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (count != null)
                Text(
                  "$count ",
                  style: isSelected
                      ? TextStyles.font13WhiteRegular
                      : TextStyles.font13PrimRegular,
                ),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: isSelected
                      ? TextStyles.font13WhiteRegular
                      : TextStyles.font13PrimRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
