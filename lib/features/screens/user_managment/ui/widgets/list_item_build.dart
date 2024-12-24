import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget listItemBuild(BuildContext context, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          context.pushNamed(
            Routes.userDetailsScreen,
            arguments: 1,
          );
        },
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: 45.w,
                height: 45.h,
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Mosad Selim',
                  style: TextStyles.font14BlackSemiBold,
                ),
                Text(
                  'mossad.selim11@gmail.com',
                  style: TextStyles.font12GreyRegular,
                ),
              ],
            ),
          ],
        ),
      ),
      Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                context.pushNamed(
                  Routes.editUserScreen,
                  arguments: 1,
                );
              },
              child: Icon(
                Icons.mode_edit_outlined,
                color: AppColor.thirdColor,
              )),
          horizontalSpace(10),
          InkWell(
              onTap: () {
                showCustomDialog(context, S.of(context).deleteMessage);
              },
              child: Icon(
                IconBroken.delete,
                color: AppColor.thirdColor,
              )),
        ],
      ),
    ],
  );
}
