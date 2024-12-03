import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_state.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/password_validation.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class NewPasswordBody extends StatefulWidget {
  const NewPasswordBody({super.key});

  @override
  State<NewPasswordBody> createState() => _NewPasswordBodyState();
}

class _NewPasswordBodyState extends State<NewPasswordBody> {
  bool isShow = false;
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    passwordController = context.read<SetPasswordCubit>().passController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetPasswordCubit, SetPasswordStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: context.read<SetPasswordCubit>().formKey,
          child: Column(
            children: [
              DefaultTextField(
                  label: S.of(context).setPassTextField1,
                  keyboardType: TextInputType.text,
                  controller: context.read<SetPasswordCubit>().passController,
                  suffixIcon: context.read<SetPasswordCubit>().suffixIcon,
                  suffixPressed: () {
                    context
                        .read<SetPasswordCubit>()
                        .changeSuffixIconVisiability();
                  },
                  obscureText: context.read<SetPasswordCubit>().ispassword,
                  onChanged: (value) {
                    if (value!.isNotEmpty) {
                      isShow = true;
                    } else {
                      isShow = false;
                    }
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                            .hasMatch(value)) {
                      S.of(context).validationPassword;
                    }
                  }),
              verticalSpace(12),
              if (isShow == true)
                PasswordValidations(
                  hasLowerCase: hasLowercase,
                  hasUpperCase: hasUppercase,
                  hasSpecialCharacters: hasSpecialCharacters,
                  hasNumber: hasNumber,
                  hasMinLength: hasMinLength,
                ),
              verticalSpace(12),
              DefaultTextField(
                label: S.of(context).setPassTextField2,
                keyboardType: TextInputType.text,
                controller:
                    context.read<SetPasswordCubit>().repeatPassController,
                suffixIcon: context.read<SetPasswordCubit>().suffixIcon,
                suffixPressed: () {
                  context
                      .read<SetPasswordCubit>()
                      .changeSuffixIconVisiability();
                },
                obscureText: context.read<SetPasswordCubit>().ispassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).validationRepeatPassword;
                  }
                  if (value !=
                      context.read<SetPasswordCubit>().passController.text) {
                  return S.of(context).validationRepeatPassword;
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
