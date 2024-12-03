import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/new_password_body.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SetPasswordbody extends StatelessWidget {
  const SetPasswordbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(40),
            Text(
              S.of(context).setPassTitle1,
              style: TextStyles.font24BlackBold,
            ),
            verticalSpace(8),
            Text(
              S.of(context).setPassTitle2,
              style: TextStyles.font16BlackRegular,
            ),
            verticalSpace(36),
            const NewPasswordBody(),
            verticalSpace(40),
            DefaultElevatedButton(
              name: S.of(context).setButton,
              color: AppColor.buttonColor,
              onPressed: () {
                if (context
                    .read<SetPasswordCubit>()
                    .formKey
                    .currentState!
                    .validate()) {}
                context.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  predicate: (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
