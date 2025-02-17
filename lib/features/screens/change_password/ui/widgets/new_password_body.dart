import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/change_password/logic/change_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/change_password/logic/change_password_state.dart';
import 'package:smart_cleaning_application/features/screens/change_password/ui/widgets/password_validation.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/widgets/add_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ChangeToNewPasswordBody extends StatefulWidget {
  const ChangeToNewPasswordBody({super.key});

  @override
  State<ChangeToNewPasswordBody> createState() =>
      _ChangeToNewPasswordBodyState();
}

class _ChangeToNewPasswordBodyState extends State<ChangeToNewPasswordBody> {
  bool isShow = false;
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController newPasswordController;
  @override
  void initState() {
    super.initState();
    newPasswordController =
        context.read<ChangePasswordCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    newPasswordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(newPasswordController.text);
        hasUppercase = AppRegex.hasUpperCase(newPasswordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(newPasswordController.text);
        hasNumber = AppRegex.hasNumber(newPasswordController.text);
        hasMinLength = AppRegex.hasMinLength(newPasswordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          toast(text: state.changePasswordModel.message!, color: Colors.blue);

          context.pop();
        }
        if (state is ChangePasswordErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Form(
          key: context.read<ChangePasswordCubit>().formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Old Password',
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(5),
              AddUserTextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller:
                    context.read<ChangePasswordCubit>().oldPasswordController,
                suffixIcon: context.read<ChangePasswordCubit>().suffixIcon,
                suffixPressed: () {
                  context
                      .read<ChangePasswordCubit>()
                      .changeSuffixIconVisiability();
                },
                obscureText: context.read<ChangePasswordCubit>().ispassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).validationPassword;
                  }
                },
                readOnly: false,
              ),
              verticalSpace(10),
              Text(
                'New Password',
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(5),
              AddUserTextFormField(
                keyboardType: TextInputType.text,
                controller:
                    context.read<ChangePasswordCubit>().passwordController,
                suffixIcon: context.read<ChangePasswordCubit>().suffixIcon,
                suffixPressed: () {
                  context
                      .read<ChangePasswordCubit>()
                      .changeSuffixIconVisiability();
                },
                obscureText: context.read<ChangePasswordCubit>().ispassword,
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
                    return S.of(context).validationPassword;
                  }
                },
                readOnly: false,
              ),
              verticalSpace(10),
              if (isShow == true)
                ChangePasswordValidations(
                  hasLowerCase: hasLowercase,
                  hasUpperCase: hasUppercase,
                  hasSpecialCharacters: hasSpecialCharacters,
                  hasNumber: hasNumber,
                  hasMinLength: hasMinLength,
                ),
              if (isShow == true) verticalSpace(12),
              Text(
                'Confirm Password',
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(5),
              AddUserTextFormField(
                keyboardType: TextInputType.text,
                controller: context
                    .read<ChangePasswordCubit>()
                    .repeatPasswordController,
                suffixIcon: context.read<ChangePasswordCubit>().suffixIcon,
                suffixPressed: () {
                  context
                      .read<ChangePasswordCubit>()
                      .changeSuffixIconVisiability();
                },
                obscureText: context.read<ChangePasswordCubit>().ispassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).validationRepeatPassword;
                  }
                  if (value !=
                      context
                          .read<ChangePasswordCubit>()
                          .passwordController
                          .text) {
                    return S.of(context).validationRepeatPassword;
                  }
                },
                readOnly: false,
              ),
              verticalSpace(30),
              DefaultElevatedButton(
                width: double.infinity,
                height: 48.h,
                name: 'Change Password',
                color: AppColor.primaryColor,
                textStyles: TextStyles.font16WhiteSemiBold,
                onPressed: () {
                  if (context
                      .read<ChangePasswordCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context.read<ChangePasswordCubit>().changePassword();
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
    newPasswordController.dispose();
    super.dispose();
  }
}
