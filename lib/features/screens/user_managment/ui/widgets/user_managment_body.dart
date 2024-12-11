import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';

class UserManagmentBody extends StatelessWidget {
  const UserManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 43.h,
                width: 101.w,
                child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(Routes.addUserScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: REdgeInsets.all(0),
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: BorderSide(
                        color: AppColor.secondaryColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        horizontalSpace(3),
                        Text(
                          'Add User',
                          style: TextStyles.font13Whitemedium,
                        ),
                      ],
                    )),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 45.w,
                      height: 45.h,
                    ),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Mosad Selim',
                        style: TextStyles.font14Primarybold,
                      ),
                      Text(
                        'mossad.selim11@gmail.com',
                        style: TextStyles.font12GreyRegular,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '(684) 555-0102',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ID Number',
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '(684) 555-0102',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Birthdate',
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    '28-4-1990',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nationality',
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Egyption',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender',
                    style: TextStyles.font14GreyRegular,
                  ),
                  Text(
                    'Female',
                    style: TextStyles.font13Blackmedium,
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showCustomDialog(context,
                            'Are You Sure You Want To Remove This User ?');
                      },
                      icon: Icon(IconBroken.delete)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.mode_edit_outlined)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.edit_note_sharp)),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
