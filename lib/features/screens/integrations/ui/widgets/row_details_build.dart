 import 'package:flutter/widgets.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget rowDetailsBuild(BuildContext context,String leadingTitle,String suffixTitle,{Color? color}) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leadingTitle,
                  style: TextStyles.font14GreyRegular.copyWith(color:color ?? AppColor.primaryColor),
                  
                ),
                Text(
                  suffixTitle,
                  style: TextStyles.font13Blackmedium.copyWith(color:color ?? AppColor.primaryColor),
                ),
              ],
            );
  }