import 'package:flutter/widgets.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ButtonsDetailsBuild extends StatelessWidget {
  const ButtonsDetailsBuild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultElevatedButton(
              name: S.of(context).editButton,
              onPressed: () {
                context.pushNamed(Routes.editUserScreen);
              },
              color: AppColor.primaryColor,
              height: 52,
              width: 158,
              textStyles: TextStyles.font20Whitesemimedium),
          DefaultElevatedButton(
              name: S.of(context).deleteButton,
              onPressed: () {
                showCustomDialog(
                    context, S.of(context).deleteMessage);
              },
              color: AppColor.primaryColor,
              height: 52,
              width: 158,
              textStyles: TextStyles.font20Whitesemimedium),
        ],
      ),
    );
  }
}