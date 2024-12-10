import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget listTileWidget(Function? onPressed, String title, IconData icon) {
  return ListTile(
    onTap: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    leading: Icon(
      icon,
      color: AppColor.primaryColor,
    ),
    title: Text(title, style: TextStyles.font14Primarybold),
    trailing: const Icon(
      Icons.arrow_forward_ios_rounded,
      color: AppColor.primaryColor,
    ),
    dense: false,
  );
}
