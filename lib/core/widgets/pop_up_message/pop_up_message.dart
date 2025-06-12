import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/widgets/pop_up_header.dart';

class PopUpMeassage extends StatelessWidget {
  final String title;
  final String body;
  final Function? onPressed;
  const PopUpMeassage(
      {super.key,
      required this.title,
      required this.body,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PopUpHeader(title: title),
            verticalSpace(10),
            Text(
              "Are you sure you want to $title this",
              style: TextStyles.font14BlackRegular,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: body,
                    style: title == 'delete'
                        ? TextStyles.font14RedRegular
                        : TextStyles.font14PrimRegular,
                  ),
                  TextSpan(
                    text: ' ?',
                    style: TextStyles.font14BlackRegular,
                  ),
                ],
              ),
            ),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: DefaultElevatedButton(
                        name: 'Yes',
                        textStyles: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          {
                            if (onPressed != null) {
                              onPressed!();
                              context.pop();
                            }
                          }
                        },
                        color: title == 'delete'
                            ? Colors.red
                            : AppColor.primaryColor,
                        height: 43.h,
                        width: double.infinity)),
                horizontalSpace(16),
                Expanded(
                    child: DefaultElevatedButton(
                        name: 'NO',
                        textStyles: title == 'delete'
                            ? TextStyles.font16RedSemiBold
                            : TextStyles.font16PrimSemiBold,
                        onPressed: () {
                          context.pop();
                        },
                        color: title == 'delete'
                            ? Color(0xffFFE3E4)
                            : AppColor.fourthColor,
                        height: 43.h,
                        width: double.infinity)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
