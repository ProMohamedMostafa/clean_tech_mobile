import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationItemBuild extends StatelessWidget {
  const WorkLocationItemBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cubit.userWorkLocationDetailsModel!.data!.areas!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Area,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount:
                        cubit.userWorkLocationDetailsModel!.data!.areas!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.areas![index].id,
                                    'selectedIndex': 0
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .areas![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.areas![index].countryName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit.userWorkLocationDetailsModel!.data!.cities!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).City,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit
                        .userWorkLocationDetailsModel!.data!.cities!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.cities![index].id,
                                    'selectedIndex': 1
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .cities![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.cities![index].areaName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit
            .userWorkLocationDetailsModel!.data!.organizations!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Organization,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit.userWorkLocationDetailsModel!.data!
                        .organizations!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.organizations![index].id,
                                    'selectedIndex': 2
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .organizations![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.organizations![index].cityName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit
            .userWorkLocationDetailsModel!.data!.buildings!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Building,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit
                        .userWorkLocationDetailsModel!.data!.buildings!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.buildings![index].id,
                                    'selectedIndex': 3
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .buildings![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.buildings![index].organizationName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit.userWorkLocationDetailsModel!.data!.floors!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Floor,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit
                        .userWorkLocationDetailsModel!.data!.floors!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.floors![index].id,
                                    'selectedIndex': 4
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .floors![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.floors![index].buildingName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit.userWorkLocationDetailsModel!.data!.sections!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Section,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit
                        .userWorkLocationDetailsModel!.data!.sections!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              if (role != 'Auditor') {
                                final result = await context.pushNamed(
                                    Routes.workLocationDetailsScreen,
                                    arguments: {
                                      'id': cubit.userWorkLocationDetailsModel!
                                          .data!.sections![index].id,
                                      'selectedIndex': 5
                                    });

                                if (result == true) {
                                  await cubit.refreshWorkLocations();
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .sections![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.sections![index].buildingName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          verticalSpace(10),
        ],
        if (cubit.userWorkLocationDetailsModel!.data!.points!.isNotEmpty) ...[
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100.h,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(1.r)),
                      ),
                      horizontalSpace(5),
                      Text(
                        S.of(context).Point,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit
                        .userWorkLocationDetailsModel!.data!.points!.length,
                    separatorBuilder: (context, index) {
                      return verticalSpace(10);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () async {
                              final result = await context.pushNamed(
                                  Routes.workLocationDetailsScreen,
                                  arguments: {
                                    'id': cubit.userWorkLocationDetailsModel!
                                        .data!.points![index].id,
                                    'selectedIndex': 6
                                  });

                              if (result == true) {
                                await cubit.refreshWorkLocations();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: AppColor.secondaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userWorkLocationDetailsModel!.data!
                                        .points![index].name!,
                                    style: TextStyles.font14BlackSemiBold,
                                  ),
                                  Text(
                                    " (${cubit.userWorkLocationDetailsModel!.data!.points![index].floorName})",
                                    style: TextStyles.font12GreyRegular,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ]
      ],
    );
  }
}
