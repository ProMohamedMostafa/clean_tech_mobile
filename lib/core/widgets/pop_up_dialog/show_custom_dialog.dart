import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

void showCustomDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          width: 343.w,
          height: 218.h,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text,
                  style: TextStyles.font16PrimSemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultElevatedButton(
                      name: S.of(context).noButtton,
                      textStyles: TextStyles.font14WhiteMedium,
                      onPressed: () {
                        context.pop();
                      },
                      color: AppColor.thirdColor,
                      height: 44,
                      width: 127),
                  DefaultElevatedButton(
                      name: S.of(context).yesButtton,
                      textStyles: TextStyles.font14WhiteMedium,
                      onPressed: () {},
                      color: AppColor.primaryColor,
                      height: 44,
                      width: 127),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
