import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class DoneScreenBody extends StatelessWidget {
  const DoneScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/done.png",
            width: 100.w,
          ),
          verticalSpace(30),
          Text(
            S.of(context).doneTitl1,
            style: TextStyles.font24BlacksemiBold,
          ),
          verticalSpace(8),
          Text(
            textAlign: TextAlign.center,
            S.of(context).doneTitl2,
            style: TextStyles.font14BlackRegular,
          ),
          verticalSpace(40),
          DefaultElevatedButton(
            name: S.of(context).donebutton,
            color: AppColor.buttonColor,
            onPressed: () {
              context.pushNamedAndRemoveUntil(
                Routes.loginScreen,
                predicate: (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
