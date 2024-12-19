import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/row_user_management_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget userDetailsBuild(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
                style: TextStyles.font14Primarybold,
              ),
              Text(
                'mossad.selim11@gmail.com',
                style: TextStyles.font12GreyRegular,
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Divider(),
      ),
      rowUserManagementDetailsBuild(
          context, S.of(context).addUserText10, '(684) 555-0102'),
      verticalSpace(5),
      rowUserManagementDetailsBuild(
          context, S.of(context).addUserText7, '(684) 555-0102'),
      verticalSpace(5),
      rowUserManagementDetailsBuild(
          context, S.of(context).addUserText4, '28-4-1990'),
      verticalSpace(5),
      rowUserManagementDetailsBuild(
          context, S.of(context).addUserText8, 'Egyption'),
      verticalSpace(5),
      rowUserManagementDetailsBuild(
          context, S.of(context).addUserText9, 'Male'),
      verticalSpace(20),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                showCustomDialog(context, S.of(context).deleteMessage);
              },
              icon: Icon(
                IconBroken.delete,
                color: AppColor.primaryColor,
              )),
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editUserScreen);
              },
              icon: Icon(
                Icons.mode_edit_outlined,
                color: AppColor.primaryColor,
              )),
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.userDetailsScreen);
              },
              icon: Icon(
                Icons.edit_note_sharp,
                color: AppColor.primaryColor,
              )),
        ],
      ),
    ],
  );
}
