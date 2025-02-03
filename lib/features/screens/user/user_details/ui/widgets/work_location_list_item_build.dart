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
          .isNotEmpty)
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
                verticalSpace(15),
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
      verticalSpace(15),
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .cities!
          .isNotEmpty)
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
                verticalSpace(15),
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
      verticalSpace(15),
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .organizations!
          .isNotEmpty)
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
                verticalSpace(15),
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
      verticalSpace(15),
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .buildings!
          .isNotEmpty)
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
                verticalSpace(15),
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
      verticalSpace(15),
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .floors!
          .isNotEmpty)
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
                verticalSpace(15),
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
      verticalSpace(15),
      if (context
          .read<UserManagementCubit>()
          .userWorkLocationDetailsModel!
          .data!
          .points!
          .isNotEmpty)
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
                verticalSpace(15),
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
    ],
  );
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   children: [
  //     Row(
  //       children: [
  //         horizontalSpace(10),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               selectedIndex == 0
  //                   ? context
  //                       .read<UserManagementCubit>().userWorkLocationDetailsModel.data.areas[]
  //                       .areaModel!
  //                       .data![index]
  //                       .name!
  //                   : selectedIndex == 1
  //                       ? context
  //                           .read<OrganizationsCubit>()
  //                           .cityModel!
  //                           .data![index]
  //                           .name!
  //                       : selectedIndex == 2
  //                           ? context
  //                               .read<OrganizationsCubit>()
  //                               .organizationModel!
  //                               .data![index]
  //                               .name!
  //                           : selectedIndex == 3
  //                               ? context
  //                                   .read<OrganizationsCubit>()
  //                                   .buildingModel!
  //                                   .data![index]
  //                                   .name!
  //                               : selectedIndex == 4
  //                                   ? context
  //                                       .read<OrganizationsCubit>()
  //                                       .floorModel!
  //                                       .data![index]
  //                                       .name!
  //                                   : context
  //                                       .read<OrganizationsCubit>()
  //                                       .pointModel!
  //                                       .data![index]
  //                                       .name!,
  //               style: TextStyles.font14BlackSemiBold,
  //             ),
  //             Text(
  //               selectedIndex == 0
  //                   ? "${context.read<OrganizationsCubit>().areaModel!.data![index].countryName}"
  //                   : selectedIndex == 1
  //                       ? "${context.read<OrganizationsCubit>().cityModel!.data![index].areaName}"
  //                       : selectedIndex == 2
  //                           ? "${context.read<OrganizationsCubit>().organizationModel!.data![index].cityName}"
  //                           : selectedIndex == 3
  //                               ? "${context.read<OrganizationsCubit>().buildingModel!.data![index].organizationName}"
  //                               : selectedIndex == 4
  //                                   ? "${context.read<OrganizationsCubit>().floorModel!.data![index].buildingName}"
  //                                   : "${context.read<OrganizationsCubit>().pointModel!.data![index].floorName}",
  //               style: TextStyles.font12GreyRegular,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  // Spacer(),
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.end,
  //   children: [
  //     InkWell(
  //         onTap: () {
  //           context.pushNamed(
  //               selectedIndex == 0
  //                   ? Routes.editAreaScreen
  //                   : selectedIndex == 1
  //                       ? Routes.editCityScreen
  //                       : selectedIndex == 2
  //                           ? Routes.editOrganizationScreen
  //                           : selectedIndex == 3
  //                               ? Routes.editBuildingScreen
  //                               : selectedIndex == 4
  //                                   ? Routes.editFloorScreen
  //                                   : Routes.editPointScreen,
  //               arguments: selectedIndex == 0
  //                   ? context
  //                       .read<OrganizationsCubit>()
  //                       .areaModel!
  //                       .data![index]
  //                       .id
  //                   : selectedIndex == 1
  //                       ? context
  //                           .read<OrganizationsCubit>()
  //                           .cityModel!
  //                           .data![index]
  //                           .id
  //                       : selectedIndex == 2
  //                           ? context
  //                               .read<OrganizationsCubit>()
  //                               .organizationModel!
  //                               .data![index]
  //                               .id
  //                           : selectedIndex == 3
  //                               ? context
  //                                   .read<OrganizationsCubit>()
  //                                   .buildingModel!
  //                                   .data![index]
  //                                   .id
  //                               : selectedIndex == 4
  //                                   ? context
  //                                       .read<OrganizationsCubit>()
  //                                       .floorModel!
  //                                       .data![index]
  //                                       .id
  //                                   : context
  //                                       .read<OrganizationsCubit>()
  //                                       .pointModel!
  //                                       .data![index]
  //                                       .id);
  //         },
  //         child: Icon(
  //           Icons.mode_edit_outlined,
  //           color: AppColor.thirdColor,
  //         )),
  //     horizontalSpace(10),
  //     InkWell(
  //         onTap: () {
  //           showCustomDialog(context, S.of(context).deleteMessage, () {
  //             selectedIndex == 0
  //                 ? context.read<OrganizationsCubit>().deleteArea(context
  //                     .read<OrganizationsCubit>()
  //                     .areaModel!
  //                     .data![index]
  //                     .id!)
  //                 : selectedIndex == 1
  //                     ? context.read<OrganizationsCubit>().deleteCity(
  //                         context
  //                             .read<OrganizationsCubit>()
  //                             .cityModel!
  //                             .data![index]
  //                             .id!)
  //                     : selectedIndex == 2
  //                         ? context
  //                             .read<OrganizationsCubit>()
  //                             .deleteOrganization(context
  //                                 .read<OrganizationsCubit>()
  //                                 .organizationModel!
  //                                 .data![index]
  //                                 .id!)
  //                         : selectedIndex == 3
  //                             ? context
  //                                 .read<OrganizationsCubit>()
  //                                 .deleteBuilding(context
  //                                     .read<OrganizationsCubit>()
  //                                     .buildingModel!
  //                                     .data![index]
  //                                     .id!)
  //                             : selectedIndex == 4
  //                                 ? context
  //                                     .read<OrganizationsCubit>()
  //                                     .deleteFloor(context
  //                                         .read<OrganizationsCubit>()
  //                                         .floorModel!
  //                                         .data![index]
  //                                         .id!)
  //                                 : context
  //                                     .read<OrganizationsCubit>()
  //                                     .deletePoint(context
  //                                         .read<OrganizationsCubit>()
  //                                         .pointModel!
  //                                         .data![index]
  //                                         .id!);

  //             context.pop();
  //           });
  //         },
  //         child: Icon(
  //           IconBroken.delete,
  //           color: AppColor.thirdColor,
  //         )),
  //   ],
  // )
  // ],
  // );
}
