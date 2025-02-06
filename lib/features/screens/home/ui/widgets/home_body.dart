import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          homeAppBar(context),
          verticalSpace(10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 244.h,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11.r),
                      border: Border.all(color: AppColor.secondaryColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Clock-In',
                                      style: TextStyles.font12GreyRegular,
                                    ),
                                    horizontalSpace(5),
                                    Container(
                                      width: 5.w,
                                      height: 5.h,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
                                    )
                                  ],
                                ),
                                verticalSpace(5),
                                Text(
                                  '00:00 --',
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Clock-Out',
                                      style: TextStyles.font12GreyRegular,
                                    ),
                                    horizontalSpace(5),
                                    Container(
                                      width: 5.w,
                                      height: 5.h,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                    )
                                  ],
                                ),
                                verticalSpace(5),
                                Text(
                                  '00:00 --',
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Duration',
                                  style: TextStyles.font12GreyRegular,
                                ),
                                verticalSpace(5),
                                Text(
                                  '1 hr, 32 min',
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            width: 85.w,
                            height: 85.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 1),
                                    color: AppColor.thirdColor)
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/click.png',
                                ),
                                verticalSpace(5),
                                Text(
                                  'Clock in',
                                  style: TextStyles.font11WhiteSemiBold,
                                )
                              ],
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Friday, ',
                                style: TextStyles.font20PrimMedium,
                              ),
                              TextSpan(
                                text: '20/12/2024',
                                style: TextStyles.font20PrimMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
