import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/default_text_form_field.dart';
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
        listener: (context, state) {},
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
              ],
            ),
          );
        },
      ),
    );
  }
}
