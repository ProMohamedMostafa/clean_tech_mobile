import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/logic/verify_account_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/widgets/otp_widget.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/widgets/receive_code.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class VerifyAccountScreenBody extends StatelessWidget {
  const VerifyAccountScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: context.read<VerifyAccountCubit>().formKey,
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
                      S.of(context).verifyAccountScreenTitle1,
                      style: TextStyles.font24BlacksemiBold,
                    ),
                    verticalSpace(12),
                    Text(
                      S.of(context).verifyAccountScreenTitle2,
                      style: TextStyles.font14GreyRegular,
                    ),
                    verticalSpace(36),
                    Center(
                      child: CustomPinCodeField(
                          pinCodeController: context
                              .read<VerifyAccountCubit>()
                              .pinCodeController),
                    ),
                    verticalSpace(24),
                    const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: ReceiveCodeText()),
                    verticalSpace(60),
                    DefaultElevatedButton(
                      width: 310,
                      height: 50,
                      name: S.of(context).verifyButton,
                      color: AppColor.primaryColor,
                      textStyles: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        if (context
                            .read<VerifyAccountCubit>()
                            .formKey
                            .currentState!
                            .validate()) {}
                        context.pushReplacementNamed(Routes.setPassScreen);
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
