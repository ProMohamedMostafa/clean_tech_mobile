import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 24.h,
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(2.r)),
        ),
        horizontalSpace(8),
        Text(S.of(context).Filter, style: TextStyles.font18BlackMedium),
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
