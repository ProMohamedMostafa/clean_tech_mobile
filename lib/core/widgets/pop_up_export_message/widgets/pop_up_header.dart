import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class PopUpHeader extends StatelessWidget {
  final String title;
  const PopUpHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 24.h,
          decoration: BoxDecoration(
              color: title == 'delete' ? Colors.red : AppColor.primaryColor,
              borderRadius: BorderRadius.circular(2.r)),
        ),
        horizontalSpace(8),
        Text(
          title[0].toUpperCase() + title.substring(1),
          style: title == 'delete'
              ? TextStyles.font18RedMedium
              : TextStyles.font18PrimMedium,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            size: 26.sp,
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
