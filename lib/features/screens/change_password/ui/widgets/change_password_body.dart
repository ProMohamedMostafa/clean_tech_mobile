import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/change_password/ui/widgets/new_password_body.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(S.of(context).change_password), leading: CustomBackButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).change_password_description,
                style: TextStyles.font14GreyRegular,
              ),
              verticalSpace(20),
              ChangeToNewPasswordBody(),
            ],
          ),
        ),
      ),
    );
  }
}
