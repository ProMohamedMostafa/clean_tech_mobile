import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/widgets/login_app_bar.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
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
        appBar: loginAppBar(),
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
                verticalSpace(24),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(Routes.forgotPasswordScreen);
                    },
                    child: Text(
                      S.of(context).forgotPassButton,
                      style: TextStyles.font13Blackmedium,
                    ),
                  ),
                ),
                verticalSpace(40),
                DefaultElevatedButton(
                  width: 310,
                  height: 50,
                  name: S.of(context).loginButton,
                  color: AppColor.primaryColor,
                  textStyles: TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    // if (context
                    //     .read<LoginCubit>()
                    //     .formKey
                    //     .currentState!
                    //     .validate()) {}
                    context.pushNamed(Routes.mainLayoutScreen);
                  },
                ),
              ],
            ),
          ),
        )));
  }
}
