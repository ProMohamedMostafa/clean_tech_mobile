import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/logic/forgot_password_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ForgotScreenBody extends StatelessWidget {
  const ForgotScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: context.read<ForgotPasswordCubit>().formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customBackButton(context),
                    Image.asset(
                      'assets/images/clean.png',
                      height: 40,
                      width: 120,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).forgotPassScreenTitle1,
                      style: TextStyles.font24BlacksemiBold,
                    ),
                    verticalSpace(15),
                    Text(
                      S.of(context).forgotPassScreenTitle2,
                      style: TextStyles.font14GreyRegular,
                    ),
                    verticalSpace(40),
                    DefaultTextField(
                      label: S.of(context).forgotPassScreenTextField,
                      keyboardType: TextInputType.emailAddress,
                      controller:
                          context.read<ForgotPasswordCubit>().emailController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isEmailValid(value)) {
                          return S.of(context).validationEmail;
                        }
                      },
                    ),
                    verticalSpace(60),
                    DefaultElevatedButton(
                      width: 310,
                      height: 50,
                      name: S.of(context).submitButton,
                      color: AppColor.primaryColor,
                      textStyles: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        if (context
                            .read<ForgotPasswordCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.pushNamed(Routes.verifyScreen);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
