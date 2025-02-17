import 'package:flutter/material.dart';
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
      color: Colors.black,
    ),
    title: Text(title,
        style: TextStyles.font14GreyRegular.copyWith(color: Colors.black)),
    trailing: const Icon(
      Icons.arrow_forward_ios_rounded,
      color: Colors.black,
    ),
    dense: false,
  );
}
