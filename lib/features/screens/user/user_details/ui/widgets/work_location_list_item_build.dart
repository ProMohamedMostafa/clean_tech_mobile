import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';

Widget listWorkLocationItemBuild(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
         ! .areas
        !  .isNotEmpty) ...[
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
                      'Area',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                     ! .areas
                      !.length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                    !  .areas![index]
                                      .id
                                    !  .toInt(),
                                  'selectedIndex': 0
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                     ! .areas![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.areas![index].countryName})",
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
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
        !  .cities
          !.isNotEmpty) ...[
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
                      'City',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                      !.cities
                     ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                    !  .cities![index]
                                      .id
                                    !  .toInt(),
                                  'selectedIndex': 1
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                     ! .cities![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.cities![index].areaName})",
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
        verticalSpace(10)
      ],
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
          !.organizations
        !  .isNotEmpty) ...[
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
                      'Organization',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                     ! .organizations
                    ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                     ! .organizations![index]
                                      .id
                                      !.toInt(),
                                  'selectedIndex': 2
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                 !     .organizations![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.organizations![index].cityName})",
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
        verticalSpace(10)
      ],
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
          !.buildings
         !.isNotEmpty) ...[
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
                      'Building',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                     ! .buildings
                     ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                      !.buildings![index]
                                      .id
                                    !  .toInt(),
                                  'selectedIndex': 3
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                     ! .buildings![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.buildings![index].organizationName})",
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
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
      !    .floors
        !  .isNotEmpty) ...[
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
                      'Floor',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                    !  .floors
                     ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                     ! .floors![index]
                                      .id
                                    !  .toInt(),
                                  'selectedIndex': 4
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                    !  .floors![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.floors![index].buildingName})",
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
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
          !.sections
         ! .isNotEmpty) ...[
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
                      'Section',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                     ! .sections
                     ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                   !   .sections![index]
                                      .id
                                   !   .toInt(),
                                  'selectedIndex': 5
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                              !        .sections![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.sections![index].floorName})",
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
      ],
      if (context
          .read<UserDetailsCubit>()
          .userWorkLocationDetailsModel!
          .data
       !   .points
       !   .isNotEmpty) ...[
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
                      'Point',
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
                verticalSpace(20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserDetailsCubit>()
                      .userWorkLocationDetailsModel!
                      .data
                   !   .points
                     ! .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.workLocationDetailsScreen,
                                arguments: {
                                  'id': context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                   !   .points![index]
                                      .id
                                     ! .toInt(),
                                  'selectedIndex': 6
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border:
                                    Border.all(color: AppColor.secondaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<UserDetailsCubit>()
                                      .userWorkLocationDetailsModel!
                                      .data
                                  !    .points![index]
                                      .name!,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                Text(
                                  " (${context.read<UserDetailsCubit>().userWorkLocationDetailsModel!.data!.points![index].sectionName})",
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
