import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';

Widget listWorkLocationItemBuild(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .areas!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .areas!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Country',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .areas![index]
                                  .countryName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'Area',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .areas![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .cities!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .cities!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Area',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .cities![index]
                                  .areaName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'City',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .cities![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .organizations!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .organizations!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'City',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .organizations![index]
                                  .cityName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'Organization',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .organizations![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .buildings!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .buildings!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Organization',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .buildings![index]
                                  .organizationName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'Building',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .buildings![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .floors!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .floors!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Building',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .floors![index]
                                  .buildingName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'Floor',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .floors![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .points!
          .isNotEmpty) ...[
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                verticalSpace(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel!
                      .data!
                      .points!
                      .length,
                  separatorBuilder: (context, index) {
                    return verticalSpace(10);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Floor',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .points![index]
                                  .floorName!,
                              style: TextStyles.font12GreyRegular,
                            ),
                            Text(
                              'Point',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                            Text(
                              context
                                  .read<UserManagementCubit>()
                                  .userWorkLocationDetailsModel!
                                  .data!
                                  .points![index]
                                  .name!,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ],
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
