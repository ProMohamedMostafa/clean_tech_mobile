import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(S.of(context).createPass1, hasLowerCase),
        verticalSpace(2),
        buildValidationRow(S.of(context).createPass2, hasUpperCase),
        verticalSpace(2),
        buildValidationRow(S.of(context).createPass3, hasSpecialCharacters),
        verticalSpace(2),
        buildValidationRow(S.of(context).createPass4, hasNumber),
        verticalSpace(2),
        buildValidationRow(S.of(context).createPass5, hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '⚈ $text',
          style: TextStyles.font13Blackmedium.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.blue,
            decorationThickness: 2,
            color: hasValidated ? Colors.blue : Colors.black,
          ),
        ),
        const Spacer()
      ],
    );
  }
}
