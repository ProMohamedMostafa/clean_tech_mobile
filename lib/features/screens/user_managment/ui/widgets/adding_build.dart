import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget addingBuild(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: SizedBox(
      height: 45.h,
      width: 110.w,
      child: ElevatedButton(
          onPressed: () {
            context.pushNamed(Routes.addUserScreen);
          },
          style: ElevatedButton.styleFrom(
            padding: REdgeInsets.all(0),
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            side: BorderSide(
              color: AppColor.secondaryColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 20.sp,
              ),
              horizontalSpace(3),
              Text(
                S.of(context).addUserButton,
                style: TextStyles.font13Whitemedium,
              ),
            ],
          )),
    ),
  );
}
