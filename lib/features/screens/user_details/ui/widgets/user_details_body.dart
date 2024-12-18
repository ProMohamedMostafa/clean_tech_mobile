import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/user_details/ui/widgets/buttons_details_build.dart';
import 'package:smart_cleaning_application/features/screens/user_details/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsBody extends StatelessWidget {
  const UserDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font24PrimsemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(15),
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.white,
                      border:
                          Border.all(color: AppColor.primaryColor, width: 3.w)),
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              verticalSpace(35),
              rowDetailsBuild(context, S.of(context).addUserText1, 'mossad'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText2, 'selim'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText3,
                  'mossad.selim11@gmail.com'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(
                  context, S.of(context).addUserText10, '01060056199'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText4, '6-6-1994'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText5, 'mosad11'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(
                  context, S.of(context).addUserText7, '(684) 555-0102'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText8, 'Egyption'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              rowDetailsBuild(context, S.of(context).addUserText9, 'Male'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              verticalSpace(35),
              ButtonsDetailsBuild(),
              verticalSpace(30),
            ],
          ),
        ),
      )),
    );
  }
}


