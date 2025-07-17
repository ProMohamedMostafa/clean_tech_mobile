import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/widgets/email_password.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    S.of(context).loginTitle1,
                    style: TextStyles.font24BlacksemiBold
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/clean.png',
                    height: 40.h,
                    width: 120.w,
                  ),
                )
              ],
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                S.of(context).loginDescription,
                style: TextStyles.font14GreyRegular,
              ),
            ),
            verticalSpace(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const EmailAndPassword(),
            ),
          ],
        ),
      )),
    );
  }
}
