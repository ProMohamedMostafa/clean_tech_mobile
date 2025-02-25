import 'package:flutter/material.dart';
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
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(80),
            Text(
              S.of(context).loginTitle1,
              style: TextStyles.font24BlacksemiBold,
            ),
            verticalSpace(12),
            Text(
              S.of(context).loginTitle2,
              style: TextStyles.font14GreyRegular,
            ),
            verticalSpace(36),
            const EmailAndPassword(),
          ],
        ),
      ),
    )));
  }
}
