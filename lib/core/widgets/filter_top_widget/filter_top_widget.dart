import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget buildHeader(BuildContext context) {
  return Row(
    children: [
      Container(width: 6.w, height: 20.h, color: AppColor.primaryColor),
      horizontalSpace(8),
      Text("Filter",
          style: TextStyles.font18PrimBold.copyWith(color: Colors.black)),
      const Spacer(),
      IconButton(
        icon: Icon(Icons.close_rounded),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}