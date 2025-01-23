import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddOrganizationBody extends StatefulWidget {
  const AddOrganizationBody({super.key});

  @override
  State<AddOrganizationBody> createState() => _AddOrganizationBodyState();
}

class _AddOrganizationBodyState extends State<AddOrganizationBody> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Area', 'icon': Icons.map},
    {'title': 'City', 'icon': Icons.location_city},
    {'title': 'Organizations', 'icon': Icons.business},
    {'title': 'Building', 'icon': Icons.house},
    {'title': 'Floor', 'icon': Icons.stairs},
    {'title': 'Point', 'icon': Icons.place},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add',
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: context.read<AddOrganizationCubit>().formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(35),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (context, index) {
                    return horizontalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Container(
                      height: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.secondaryColor)),
                      child: ListTile(
                        leading:
                            Icon(item['icon'], color: AppColor.primaryColor),
                        title: Text(item['title'],
                            style: TextStyles.font16PrimSemiBold),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: AppColor.primaryColor),
                        onTap: () {
                          index == 0
                              ? context.pushNamed(Routes.addAreaScreen)
                              : index == 1
                                  ? context.pushNamed(Routes.addCityScreen)
                                  : index == 2
                                      ? context.pushNamed(
                                          Routes.addOrganizationDetailsScreen)
                                      : index == 3
                                          ? context.pushNamed(
                                              Routes.addBuildingScreen)
                                          : index == 4
                                              ? context.pushNamed(
                                                  Routes.addFloorScreen)
                                              : context.pushNamed(
                                                  Routes.addPointScreen);
                        },
                      ),
                    );
                  },
                ),
                // Text(
                //   "Area",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //   height: 49.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // final cubit =
                //       //     context.read<AddOrganizationCubit>();
                //       // AddAreaBottomDialog()
                //       //     .showBottomDialog(context, cubit);
                //       context.pushNamed(Routes.addAreaScreen);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: REdgeInsets.all(0),
                //       backgroundColor: AppColor.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       side: BorderSide(
                //         color: AppColor.secondaryColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: Icon(
                //       Icons.add_circle_outline_sharp,
                //       color: Colors.white,
                //       size: 22.sp,
                //     ),
                //   ),
                // ),
                // verticalSpace(10),
                // Text(
                //   "City",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //   height: 49.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       context.pushNamed(Routes.addCityScreen);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: REdgeInsets.all(0),
                //       backgroundColor: AppColor.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       side: BorderSide(
                //         color: AppColor.secondaryColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: Icon(
                //       Icons.add_circle_outline_sharp,
                //       color: Colors.white,
                //       size: 22.sp,
                //     ),
                //   ),
                // ),
                // verticalSpace(10),
                // Text(
                //   "Organizations",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //     height: 49.h,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         context.pushNamed(Routes.addOrganizationDetailsScreen);
                //       },
                //       style: ElevatedButton.styleFrom(
                //         padding: REdgeInsets.all(0),
                //         backgroundColor: AppColor.primaryColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8.r),
                //         ),
                //         side: BorderSide(
                //           color: AppColor.secondaryColor,
                //           width: 1,
                //         ),
                //       ),
                //       child: Icon(
                //         Icons.add_circle_outline_sharp,
                //         color: Colors.white,
                //         size: 22.sp,
                //       ),
                //     )),
                // verticalSpace(10),
                // Text(
                //   "Building",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //   height: 49.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       context.pushNamed(Routes.addBuildingScreen);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: REdgeInsets.all(0),
                //       backgroundColor: AppColor.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       side: BorderSide(
                //         color: AppColor.secondaryColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: Icon(
                //       Icons.add_circle_outline_sharp,
                //       color: Colors.white,
                //       size: 22.sp,
                //     ),
                //   ),
                // ),
                // verticalSpace(10),
                // Text(
                //   "Floor",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //   height: 49.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       context.pushNamed(Routes.addFloorScreen);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: REdgeInsets.all(0),
                //       backgroundColor: AppColor.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       side: BorderSide(
                //         color: AppColor.secondaryColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: Icon(
                //       Icons.add_circle_outline_sharp,
                //       color: Colors.white,
                //       size: 22.sp,
                //     ),
                //   ),
                // ),
                // verticalSpace(10),
                // Text(
                //   "Point",
                //   style: TextStyles.font16BlackRegular,
                // ),
                // SizedBox(
                //   height: 49.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       context.pushNamed(Routes.addPointScreen);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: REdgeInsets.all(0),
                //       backgroundColor: AppColor.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       side: BorderSide(
                //         color: AppColor.secondaryColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: Icon(
                //       Icons.add_circle_outline_sharp,
                //       color: Colors.white,
                //       size: 22.sp,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
