import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/login/logic/login_cubit_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Form(
            key: formKey,
            child: Column(
              children: [
                DefaultTextField(
                  label: S.of(context).labelEmail,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).validationEmail;
                    }
                  },
                ),
                verticalSpace(12),
                DefaultTextField(
                    label: S.of(context).labelPassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    suffixIcon: cubit.suffixIcon,
                    suffixPressed: () {
                      cubit.changeSuffixIconVisiability();
                    },
                    obscureText: cubit.ispassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        S.of(context).validationPassword;
                      }

                      return null;
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
