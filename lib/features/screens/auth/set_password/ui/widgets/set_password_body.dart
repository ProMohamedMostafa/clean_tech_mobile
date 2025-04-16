import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_state.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/new_password_body.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SetPasswordbody extends StatelessWidget {
  final String email;
  final int code;
  const SetPasswordbody({super.key, required this.email, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetPasswordCubit, SetPasswordStates>(
      listener: (context, state) {
        if (state is SetPasswordSuccessState) {
          toast(text: state.message, color: Colors.blue);
          context.pushNamed(Routes.doneScreen);
        }
        if (state is SetPasswordErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
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
                        S.of(context).setPassTitle1,
                        style: TextStyles.font24BlacksemiBold,
                      ),
                      verticalSpace(12),
                      Text(
                        S.of(context).setPassTitle2,
                        style: TextStyles.font14GreyRegular,
                      ),
                      verticalSpace(36),
                      const NewPasswordBody(),
                      verticalSpace(60),
                      state is SetPasswordLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              width: 310,
                              height: 50,
                              name: S.of(context).setButton,
                              color: AppColor.primaryColor,
                              textStyles: TextStyles.font16WhiteSemiBold,
                              onPressed: () {
                                if (context
                                    .read<SetPasswordCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context
                                      .read<SetPasswordCubit>()
                                      .resetPassword(email, code);
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
