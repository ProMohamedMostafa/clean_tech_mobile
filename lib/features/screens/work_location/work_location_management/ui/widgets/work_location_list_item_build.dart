import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget organizationsListItemBuild(
    BuildContext context, int selectedIndex, index) {
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(Routes.workLocationDetailsScreen, arguments: {
        'id': selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaModel!
                .data!
                .data![index]
                .id!
                .toInt()
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityModel!
                    .data!
                    .data![index]
                    .id!
                    .toInt()
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationModel!
                        .data!
                        .data![index]
                        .id!
                        .toInt()
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingModel!
                            .data!
                            .data![index]
                            .id!
                            .toInt()
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorModel!
                                .data!
                                .data![index]
                                .id!
                                .toInt()
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionModel!
                                    .data!
                                    .data![index]
                                    .id!
                                    .toInt()
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointModel!
                                    .data!
                                    .data![index]
                                    .id!
                                    .toInt(),
        'selectedIndex': selectedIndex
      });
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
          side: BorderSide(color: AppColor.secondaryColor)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minTileHeight: 72.h,
        leading: Icon(
          selectedIndex == 0
              ? Icons.map
              : selectedIndex == 1
                  ? Icons.location_city
                  : selectedIndex == 2
                      ? Icons.business
                      : selectedIndex == 3
                          ? Icons.home_work
                          : selectedIndex == 4
                              ? Icons.house
                              : selectedIndex == 5
                                  ? Icons.stairs
                                  : Icons.place,
          color: AppColor.primaryColor,
        ),
        title: Text(
          selectedIndex == 0
              ? context
                  .read<WorkLocationCubit>()
                  .areaModel!
                  .data!
                  .data![index]
                  .name!
              : selectedIndex == 1
                  ? context
                      .read<WorkLocationCubit>()
                      .cityModel!
                      .data!
                      .data![index]
                      .name!
                  : selectedIndex == 2
                      ? context
                          .read<WorkLocationCubit>()
                          .organizationModel!
                          .data!
                          .data![index]
                          .name!
                      : selectedIndex == 3
                          ? context
                              .read<WorkLocationCubit>()
                              .buildingModel!
                              .data!
                              .data![index]
                              .name!
                          : selectedIndex == 4
                              ? context
                                  .read<WorkLocationCubit>()
                                  .floorModel!
                                  .data!
                                  .data![index]
                                  .name!
                              : selectedIndex == 5
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .sectionModel!
                                      .data!
                                      .data![index]
                                      .name!
                                  : context
                                      .read<WorkLocationCubit>()
                                      .pointModel!
                                      .data!
                                      .data![index]
                                      .name!,
          style: TextStyles.font14Primarybold,
        ),
        subtitle: Text(
          selectedIndex == 0
              ? "${context.read<WorkLocationCubit>().areaModel!.data!.data![index].countryName}"
              : selectedIndex == 1
                  ? "${context.read<WorkLocationCubit>().cityModel!.data!.data![index].areaName}"
                  : selectedIndex == 2
                      ? "${context.read<WorkLocationCubit>().organizationModel!.data!.data![index].cityName}"
                      : selectedIndex == 3
                          ? "${context.read<WorkLocationCubit>().buildingModel!.data!.data![index].organizationName}"
                          : selectedIndex == 4
                              ? "${context.read<WorkLocationCubit>().floorModel!.data!.data![index].buildingName}"
                              : selectedIndex == 5
                                  ? "${context.read<WorkLocationCubit>().sectionModel!.data!.data![index].floorName}"
                                  : "${context.read<WorkLocationCubit>().pointModel!.data!.data![index].sectionName}",
          style: TextStyles.font12GreyRegular,
        ),
        trailing: role == 'Admin'
            ? SizedBox(
                width: 80.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          context.pushNamed(
                              selectedIndex == 0
                                  ? Routes.editAreaScreen
                                  : selectedIndex == 1
                                      ? Routes.editCityScreen
                                      : selectedIndex == 2
                                          ? Routes.editOrganizationScreen
                                          : selectedIndex == 3
                                              ? Routes.editBuildingScreen
                                              : selectedIndex == 4
                                                  ? Routes.editFloorScreen
                                                  : selectedIndex == 5
                                                      ? Routes.editSectionScreen
                                                      : Routes.editPointScreen,
                              arguments: selectedIndex == 0
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .areaModel!
                                      .data!
                                      .data![index]
                                      .id
                                  : selectedIndex == 1
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .cityModel!
                                          .data!
                                          .data![index]
                                          .id
                                      : selectedIndex == 2
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .organizationModel!
                                              .data!
                                              .data![index]
                                              .id
                                          : selectedIndex == 3
                                              ? context
                                                  .read<WorkLocationCubit>()
                                                  .buildingModel!
                                                  .data!
                                                  .data![index]
                                                  .id
                                              : selectedIndex == 4
                                                  ? context
                                                      .read<WorkLocationCubit>()
                                                      .floorModel!
                                                      .data!
                                                      .data![index]
                                                      .id
                                                  : selectedIndex == 5
                                                      ? context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .sectionModel!
                                                          .data!
                                                          .data![index]
                                                          .id
                                                      : context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .pointModel!
                                                          .data!
                                                          .data![index]
                                                          .id);
                        },
                        child: Icon(
                          Icons.mode_edit_outlined,
                          color: AppColor.thirdColor,
                        )),
                    horizontalSpace(10),
                    InkWell(
                        onTap: () {
                          showCustomDialog(context, 'Are you want to delete ?',
                              () {
                            selectedIndex == 0
                                ? context.read<WorkLocationCubit>().deleteArea(context
                                    .read<WorkLocationCubit>()
                                    .areaModel!
                                    .data!
                                    .data![index]
                                    .id!)
                                : selectedIndex == 1
                                    ? context
                                        .read<WorkLocationCubit>()
                                        .deleteCity(context
                                            .read<WorkLocationCubit>()
                                            .cityModel!
                                            .data!
                                            .data![index]
                                            .id!)
                                    : selectedIndex == 2
                                        ? context
                                            .read<WorkLocationCubit>()
                                            .deleteOrganization(context
                                                .read<WorkLocationCubit>()
                                                .organizationModel!
                                                .data!
                                                .data![index]
                                                .id!)
                                        : selectedIndex == 3
                                            ? context
                                                .read<WorkLocationCubit>()
                                                .deleteBuilding(context
                                                    .read<WorkLocationCubit>()
                                                    .buildingModel!
                                                    .data!
                                                    .data![index]
                                                    .id!)
                                            : selectedIndex == 4
                                                ? context.read<WorkLocationCubit>().deleteFloor(context
                                                    .read<WorkLocationCubit>()
                                                    .floorModel!
                                                    .data!
                                                    .data![index]
                                                    .id!)
                                                : selectedIndex == 5
                                                    ? context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .deleteSection(context
                                                            .read<
                                                                WorkLocationCubit>()
                                                            .sectionModel!
                                                            .data!
                                                            .data![index]
                                                            .id!)
                                                    : context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .deletePoint(context
                                                            .read<WorkLocationCubit>()
                                                            .pointModel!
                                                            .data!
                                                            .data![index]
                                                            .id!);

                            context.pop();
                          });
                        },
                        child: Icon(
                          IconBroken.delete,
                          color: AppColor.thirdColor,
                        )),
                  ],
                ))
            : SizedBox.shrink(),
      ),
    ),
  );
}
