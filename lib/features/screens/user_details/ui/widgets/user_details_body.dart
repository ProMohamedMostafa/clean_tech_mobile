import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsBody extends StatelessWidget {
  const UserDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font24PrimsemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(15),
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.white,
                      border:
                          Border.all(color: AppColor.primaryColor, width: 3.w)),
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              verticalSpace(35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText1,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'mossad',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText2,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'selim',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'mossad.selim11@gmail.com',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText10,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '01060056199',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText4,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '6-6-1994',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText5,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'mosad11',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText7,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '(684) 555-0102',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText8,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Egyption',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addUserText9,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Male',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              verticalSpace(35),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultElevatedButton(
                                               name: S.of(context).editButton,

                        onPressed: () {
                          context.pushNamed(Routes.editUserScreen);
                        },
                        color: AppColor.primaryColor,
                        height: 52,
                        width: 158,
                        textStyles: TextStyles.font20Whitesemimedium),
                    DefaultElevatedButton(
                        name: S.of(context).deleteButton,
                        onPressed: () {
                          showCustomDialog(
                              context, S.of(context).deleteMessage);
                        },
                        color: AppColor.primaryColor,
                        height: 52,
                        width: 158,
                        textStyles: TextStyles.font20Whitesemimedium),
                  ],
                ),
              ),
              verticalSpace(30),
            ],
          ),
        ),
      )),
    );
  }
}
