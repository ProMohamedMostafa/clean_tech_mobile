import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/widgets/email_password.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 180.h,
                width: 170.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clipper.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    S.of(context).loginTitle1,
                    style: TextStyles.font24BlacksemiBold
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/images/clean.png',
                  height: 40,
                  width: 120,
                ),
              )
            ],
          ),
          verticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Login to access your Clean Tech\naccount',
              style: TextStyles.font14GreyRegular,
            ),
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: const EmailAndPassword(),
          ),
        ],
      ),
    ));
  }
}
