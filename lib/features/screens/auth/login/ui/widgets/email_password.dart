import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          toast(text: state.loginmodel.message!, color: Colors.blue);
          context.pushNamedAndRemoveUntil(
            Routes.mainLayoutScreen,
            predicate: (route) => false,
          );
        }
        if (state is LoginErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Form(
          key: context.read<LoginCubit>().formKey,
          child: Column(
            children: [
              DefaultTextField(
                label: S.of(context).labelEmail,
                keyboardType: TextInputType.emailAddress,
                controller: context.read<LoginCubit>().emailController,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).validationEmailAndUser;
                  } else if (value.length > 55) {
                    return S.of(context).validationUsernameTooLong;
                  } else if (value.length < 3) {
                    return S.of(context).validationUsernameTooShort;
                  }
                },
              ),
              verticalSpace(12),
              DefaultTextField(
                  label: S.of(context).labelPassword,
                  keyboardType: TextInputType.visiblePassword,
                  controller: context.read<LoginCubit>().passwordController,
                  suffixIcon: context.read<LoginCubit>().suffixIcon,
                  suffixPressed: () {
                    context.read<LoginCubit>().changeSuffixIconVisiability();
                  },
                  obscureText: context.read<LoginCubit>().ispassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).validationPassword;
                    } else if (value.length < 8) {
                      return S.of(context).validationAddPasswordConfirmation;
                    }
                  }),
              verticalSpace(15),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {
                    context.pushNamed(Routes.forgotPasswordScreen);
                  },
                  child: Text(
                    S.of(context).forgotPassButton,
                    style: TextStyles.font12GreyRegular
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ),
              ),
              verticalSpace(60),
              state is LoginLoadingState
                  ?  Loading()
                  : DefaultElevatedButton(
                      width: 310,
                      height: 50,
                      name: S.of(context).loginButton,
                      color: AppColor.primaryColor,
                      textStyles: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        context.read<BottomNavbarCubit>().currentIndex = 0;
                        if (context
                            .read<LoginCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<LoginCubit>().userLogin(context);
                        }
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}
