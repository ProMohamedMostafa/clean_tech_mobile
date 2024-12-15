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
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
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
                      }
                    }),
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
                state is LoginLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor),
                      )
                    : DefaultElevatedButton(
                        width: 310,
                        height: 50,
                        name: S.of(context).loginButton,
                        color: AppColor.primaryColor,
                        textStyles: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(
                            Routes.mainLayoutScreen,
                            predicate: (route) => false,
                          );
                          // if (context
                          //     .read<LoginCubit>()
                          //     .formKey
                          //     .currentState!
                          //     .validate()) {
                          //   context.read<LoginCubit>().userLogin();
                          // }
                        },
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
