import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_cubit.dart';

Widget organizationsListItemBuild(BuildContext context, selectedIndex, index) {
  return InkWell(
    onTap: () {
      context.pushNamed(
          selectedIndex == 0
              ? Routes.areaDetailsScreen
              : selectedIndex == 1
                  ? Routes.cityDetailsScreen
                  : selectedIndex == 2
                      ? Routes.organizationDetailsScreen
                      : selectedIndex == 3
                          ? Routes.buildingDetailsScreen
                          : selectedIndex == 4
                              ? Routes.floorDetailsScreen
                              : Routes.pointDetailsScreen,
          arguments: selectedIndex == 0
              ? context
                  .read<OrganizationsCubit>()
                  .areaModel!
                  .data!
                  .areas![index]
                  .id
              : selectedIndex == 1
                  ? context
                      .read<OrganizationsCubit>()
                      .cityModel!
                      .data!
                      .data![index]
                      .id
                  : selectedIndex == 2
                      ? context
                          .read<OrganizationsCubit>()
                          .organizationModel!
                          .data!
                          .data![index]
                          .id
                      : selectedIndex == 3
                          ? context
                              .read<OrganizationsCubit>()
                              .buildingModel!
                              .data!
                              .data![index]
                              .id
                          : selectedIndex == 4
                              ? context
                                  .read<OrganizationsCubit>()
                                  .floorModel!
                                  .data!
                                  .data![index]
                                  .id
                              : context
                                  .read<OrganizationsCubit>()
                                  .pointModel!
                                  .data!
                                  .data![index]
                                  .id);
    },
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      minTileHeight: 50.h,
      title: Text(
        selectedIndex == 0
            ? context
                .read<OrganizationsCubit>()
                .areaModel!
                .data!
                .areas![index]
                .name!
            : selectedIndex == 1
                ? context
                    .read<OrganizationsCubit>()
                    .cityModel!
                    .data!
                    .data![index]
                    .name!
                : selectedIndex == 2
                    ? context
                        .read<OrganizationsCubit>()
                        .organizationModel!
                        .data!
                        .data![index]
                        .name!
                    : selectedIndex == 3
                        ? context
                            .read<OrganizationsCubit>()
                            .buildingModel!
                            .data!
                            .data![index]
                            .name!
                        : selectedIndex == 4
                            ? context
                                .read<OrganizationsCubit>()
                                .floorModel!
                                .data!
                                .data![index]
                                .name!
                            : context
                                .read<OrganizationsCubit>()
                                .pointModel!
                                .data!
                                .data![index]
                                .name!,
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? "${context.read<OrganizationsCubit>().areaModel!.data!.areas![index].countryName}"
            : selectedIndex == 1
                ? "${context.read<OrganizationsCubit>().cityModel!.data!.data![index].areaName}"
                : selectedIndex == 2
                    ? "${context.read<OrganizationsCubit>().organizationModel!.data!.data![index].cityName}"
                    : selectedIndex == 3
                        ? "${context.read<OrganizationsCubit>().buildingModel!.data!.data![index].organizationName}"
                        : selectedIndex == 4
                            ? "${context.read<OrganizationsCubit>().floorModel!.data!.data![index].buildingName}"
                            : "${context.read<OrganizationsCubit>().pointModel!.data!.data![index].floorName}",
        style: TextStyles.font12GreyRegular,
      ),
      trailing: SizedBox(
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
                                            : Routes.editPointScreen,
                        arguments: selectedIndex == 0
                            ? context
                                .read<OrganizationsCubit>()
                                .areaModel!
                                .data!
                                .areas![index]
                                .id
                            : selectedIndex == 1
                                ? context
                                    .read<OrganizationsCubit>()
                                    .cityModel!
                                    .data!
                                    .data![index]
                                    .id
                                : selectedIndex == 2
                                    ? context
                                        .read<OrganizationsCubit>()
                                        .organizationModel!
                                        .data!
                                        .data![index]
                                        .id
                                    : selectedIndex == 3
                                        ? context
                                            .read<OrganizationsCubit>()
                                            .buildingModel!
                                            .data!
                                            .data![index]
                                            .id
                                        : selectedIndex == 4
                                            ? context
                                                .read<OrganizationsCubit>()
                                                .floorModel!
                                                .data!
                                                .data![index]
                                                .id
                                            : context
                                                .read<OrganizationsCubit>()
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
                    showCustomDialog(context, 'Are you want to delete ?', () {
                      selectedIndex == 0
                          ? context.read<OrganizationsCubit>().deleteArea(
                              context
                                  .read<OrganizationsCubit>()
                                  .areaModel!
                                  .data!
                                  .areas![index]
                                  .id!)
                          : selectedIndex == 1
                              ? context.read<OrganizationsCubit>().deleteCity(
                                  context
                                      .read<OrganizationsCubit>()
                                      .cityModel!
                                      .data!
                                      .data![index]
                                      .id!)
                              : selectedIndex == 2
                                  ? context
                                      .read<OrganizationsCubit>()
                                      .deleteOrganization(context
                                          .read<OrganizationsCubit>()
                                          .organizationModel!
                                          .data!
                                          .data![index]
                                          .id!)
                                  : selectedIndex == 3
                                      ? context
                                          .read<OrganizationsCubit>()
                                          .deleteBuilding(context
                                              .read<OrganizationsCubit>()
                                              .buildingModel!
                                              .data!
                                              .data![index]
                                              .id!)
                                      : selectedIndex == 4
                                          ? context
                                              .read<OrganizationsCubit>()
                                              .deleteFloor(context
                                                  .read<OrganizationsCubit>()
                                                  .floorModel!
                                                  .data!
                                                  .data![index]
                                                  .id!)
                                          : context
                                              .read<OrganizationsCubit>()
                                              .deletePoint(context
                                                  .read<OrganizationsCubit>()
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
          )),
    ),
  );
}
