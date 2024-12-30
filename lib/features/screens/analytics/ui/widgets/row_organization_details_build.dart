import 'package:flutter/widgets.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget rowOrganizationDetailsBuild(
    BuildContext context, String leadingTitle, String suffixTitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leadingTitle,
        style: TextStyles.font14GreyRegular,
      ),
      Text(
        suffixTitle,
        style: TextStyles.font13Blackmedium,
      ),
    ],
  );
}
