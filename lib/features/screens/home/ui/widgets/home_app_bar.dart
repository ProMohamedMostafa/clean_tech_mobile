import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification_build.dart';

Widget homeAppBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.secondaryColor,
                  width: 1.w,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  '${ApiConstants.apiBaseUrlImage}${context.read<HomeCubit>().profileModel!.data!.image}',
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/person.png',
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ),
            horizontalSpace(5),
            InkWell(
              onTap: () {
                context.read<BottomNavbarCubit>().changeBottomNavbar(3);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hey, ',
                          style: TextStyles.font16BlackSemiBold,
                        ),
                        TextSpan(
                          text: context
                              .read<HomeCubit>()
                              .profileModel!
                              .data!
                              .firstName!,
                          style: TextStyles.font16BlackSemiBold,
                        ),
                        TextSpan(
                          text: '..👋',
                          style: TextStyles.font16BlackSemiBold,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    context.read<HomeCubit>().profileModel!.data!.role!,
                    style: TextStyles.font11BlackMedium,
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.notificationScreen);
              },
              icon: notificationBuild(context),
            )
          ],
        ),
        // SizedBox(
        //   height: 45.h,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         flex: 1,
        //         child: IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //               Icons.filter_list,
        //               color: Colors.white,
        //               size: 30.sp,
        //             )),
        //       ),
        //       horizontalSpace(10),
        //       Expanded(
        //         flex: 7,
        //         child: SearchTextField(
        //             readOnly: false,
        //             controller:
        //                 context.read<BottomNavbarCubit>().searchController,
        //             hintText: "Search",
        //             obscureText: false,
        //             keyboardType: TextInputType.text,
        //             prefixIcon: Icon(
        //               IconBroken.Search,
        //               size: 22.sp,
        //             )),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}
