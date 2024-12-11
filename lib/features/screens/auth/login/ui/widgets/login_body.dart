import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';
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
        appBar: AppBar(
          leading: SizedBox.shrink(),
          actions: [
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      final newLanguage =
                          context.read<AppCubit>().locale.toString() == 'en'
                              ? 'ar'
                              : 'en';
                      context.read<AppCubit>().changeLanguage(newLanguage);
                    },
                    child: Text(
                      context.read<AppCubit>().locale.toString() == 'en'
                          ? 'AR'
                          : 'EN',
                      style: TextStyles.font14Primarybold,
                    ),
                  ),
                );
              },
            )
          ],
        ),
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
                  name: S.of(context).loginButton,
                  color: AppColor.primaryColor,
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
