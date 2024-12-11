import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification_build.dart';

Widget homeAppBar(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryColor,
    statusBarIconBrightness: Brightness.light,
  ));
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r))),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.read<BottomNavbarCubit>().changeBottomNavbar(3);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Mosad Selim',
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                    Text(
                      'Admin',
                      style: TextStyles.font14GreyRegular,
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                  onTap: () {},
                  child: Icon(
                    IconBroken.search,
                    size: 27.sp,
                    color: Colors.white,
                  )),
              IconButton(
                onPressed: () {},
                icon: notificationBuild(),
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
    ),
  );
}
