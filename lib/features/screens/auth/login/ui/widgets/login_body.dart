import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/widgets/email_password.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).loginTitle1,
                  style: TextStyles.font24BlacksemiBold,
                ),
                verticalSpace(8),
                Text(
                  S.of(context).loginTitle2,
                  style: TextStyles.font14BlackRegular,
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
                      style: TextStyles.font16BlackRegular,
                    ),
                  ),
                ),
                verticalSpace(40),
                DefaultElevatedButton(
                  name: S.of(context).loginButton,
                  color: AppColor.buttonColor,
                  onPressed: () {
                    if (context
                        .read<LoginCubit>()
                        .formKey
                        .currentState!
                        .validate()) {}
                  },
                ),
               
              ],
            ),
          ),
        ),
      )),
    );
  }
}
