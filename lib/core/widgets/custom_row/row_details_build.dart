import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget rowDetailsBuild(
    BuildContext context, String leadingTitle, String suffixTitle,
    {Color? leadingColor,Color? suffixColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leadingTitle,
        style:
            TextStyles.font14GreyRegular.copyWith(color: leadingColor ?? Colors.black),
      ),
      Flexible(
        child: Text(
          suffixTitle.length > 20
              ? "${suffixTitle.substring(0, 15)}..."
              : suffixTitle,
          style: TextStyles.font13Blackmedium.copyWith(
            color: suffixColor ?? AppColor.thirdColor,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    ],
  );
}
