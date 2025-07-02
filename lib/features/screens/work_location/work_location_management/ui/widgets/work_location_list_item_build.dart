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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

class WorkLocationListItemBuild extends StatelessWidget {
  final int selectedIndex;
  final int index;
  const WorkLocationListItemBuild(
      {super.key, required this.selectedIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        // if (selectedIndex == 0) {
        //   final result = await context
        //       .pushNamed(Routes.workLocationDetailsScreen, arguments: {
        //     'id': cubit.areaModel!.data!.data![index].id!.toInt(),
        //     'selectedIndex': 0
        //   });
        //   if (result == true) {
        //     cubit.getArea();
        //   }
        // }

        // if (selectedIndex == 6) {
        //   final result = await context
        //       .pushNamed(Routes.workLocationDetailsScreen, arguments: {
        //     'id': cubit.pointModel!.data!.data![index].id!.toInt(),
        //     'selectedIndex': 6
        //   });
        //   if (result == true) {
        //     cubit.getPoint();
        //   }
        // }
        if (cubit.tapIndex == 0) {
          final result = await context
              .pushNamed(Routes.workLocationDetailsScreen, arguments: {
            'id': selectedIndex == 0
                ? cubit.areaModel!.data!.data![index].id!.toInt()
                : selectedIndex == 1
                    ? cubit.cityModel!.data!.data![index].id!.toInt()
                    : selectedIndex == 2
                        ? cubit.organizationModel!.data!.data![index].id!
                            .toInt()
                        : selectedIndex == 3
                            ? cubit.buildingModel!.data!.data![index].id!
                                .toInt()
                            : selectedIndex == 4
                                ? cubit.floorModel!.data!.data![index].id!
                                    .toInt()
                                : selectedIndex == 5
                                    ? cubit.sectionModel!.data!.data![index].id!
                                        .toInt()
                                    : cubit.pointModel!.data!.data![index].id!
                                        .toInt(),
            'selectedIndex': selectedIndex
          });

          if (result == true) {
            selectedIndex == 0
                ? cubit.refreshAreas()
                : selectedIndex == 1
                    ? cubit.refreshCities()
                    : selectedIndex == 2
                        ? cubit.refreshOrganizations()
                        : selectedIndex == 3
                            ? cubit.refreshBuildings()
                            : selectedIndex == 4
                                ? cubit.refreshFloors()
                                : selectedIndex == 5
                                    ? cubit.refreshSections()
                                    : cubit.refreshPoints();
          }
        }
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
            cubit.tapIndex == 0
                ? selectedIndex == 0
                    ? cubit.areaModel!.data!.data![index].name!
                    : selectedIndex == 1
                        ? cubit.cityModel!.data!.data![index].name!
                        : selectedIndex == 2
                            ? cubit.organizationModel!.data!.data![index].name!
                            : selectedIndex == 3
                                ? cubit.buildingModel!.data!.data![index].name!
                                : selectedIndex == 4
                                    ? cubit.floorModel!.data!.data![index].name!
                                    : selectedIndex == 5
                                        ? cubit.sectionModel!.data!.data![index]
                                            .name!
                                        : cubit.pointModel!.data!.data![index]
                                            .name!
                : selectedIndex == 0
                    ? cubit.deletedAreaList!.data![index].name!
                    : selectedIndex == 1
                        ? cubit.deletedCityList!.data![index].name!
                        : selectedIndex == 2
                            ? cubit.deletedOrganizationList!.data![index].name!
                            : selectedIndex == 3
                                ? cubit.deletedBuildingList!.data![index].name!
                                : selectedIndex == 4
                                    ? cubit.deletedFloorList!.data![index].name!
                                    : selectedIndex == 5
                                        ? cubit.deletedSectionList!.data![index]
                                            .name!
                                        : cubit.deletedPointList!.data![index]
                                            .name!,
            style: TextStyles.font14Primarybold,
          ),
          subtitle: Text(
            cubit.tapIndex == 0
                ? selectedIndex == 0
                    ? "${cubit.areaModel!.data!.data![index].countryName}"
                    : selectedIndex == 1
                        ? "${cubit.cityModel!.data!.data![index].areaName}"
                        : selectedIndex == 2
                            ? "${cubit.organizationModel!.data!.data![index].cityName}"
                            : selectedIndex == 3
                                ? "${cubit.buildingModel!.data!.data![index].organizationName}"
                                : selectedIndex == 4
                                    ? "${cubit.floorModel!.data!.data![index].buildingName}"
                                    : selectedIndex == 5
                                        ? "${cubit.sectionModel!.data!.data![index].floorName}"
                                        : "${cubit.pointModel!.data!.data![index].sectionName}"
                : selectedIndex == 0
                    ? cubit.deletedAreaList!.data![index].countryName!
                    : selectedIndex == 1
                        ? cubit.deletedCityList!.data![index].areaName!
                        : selectedIndex == 2
                            ? cubit
                                .deletedOrganizationList!.data![index].cityName!
                            : selectedIndex == 3
                                ? cubit.deletedBuildingList!.data![index]
                                    .organizationName!
                                : selectedIndex == 4
                                    ? cubit.deletedFloorList!.data![index]
                                        .buildingName!
                                    : selectedIndex == 5
                                        ? cubit.deletedSectionList!.data![index]
                                            .floorName!
                                        : cubit.deletedPointList!.data![index]
                                            .sectionName!,
            style: TextStyles.font12GreyRegular,
          ),
          trailing: role == 'Admin'
              ? SizedBox(
                  width: 80.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () async {
                            if (cubit.tapIndex == 0) {
                              final result = await context.pushNamed(
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
                                                          ? Routes
                                                              .editSectionScreen
                                                          : Routes
                                                              .editPointScreen,
                                  arguments: selectedIndex == 0
                                      ? cubit.areaModel!.data!.data![index].id
                                      : selectedIndex == 1
                                          ? cubit
                                              .cityModel!.data!.data![index].id
                                          : selectedIndex == 2
                                              ? cubit.organizationModel!.data!
                                                  .data![index].id
                                              : selectedIndex == 3
                                                  ? cubit.buildingModel!.data!
                                                      .data![index].id
                                                  : selectedIndex == 4
                                                      ? cubit.floorModel!.data!
                                                          .data![index].id
                                                      : selectedIndex == 5
                                                          ? cubit
                                                              .sectionModel!
                                                              .data!
                                                              .data![index]
                                                              .id
                                                          : cubit
                                                              .pointModel!
                                                              .data!
                                                              .data![index]
                                                              .id);
                              if (result == true) {
                                selectedIndex == 0
                                    ? cubit.refreshAreas()
                                    : selectedIndex == 1
                                        ? cubit.refreshCities()
                                        : selectedIndex == 2
                                            ? cubit.refreshOrganizations()
                                            : selectedIndex == 3
                                                ? cubit.refreshBuildings()
                                                : selectedIndex == 4
                                                    ? cubit.refreshFloors()
                                                    : selectedIndex == 5
                                                        ? cubit
                                                            .refreshSections()
                                                        : cubit.refreshPoints();
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return PopUpMessage(
                                        title: 'restore',
                                        body: selectedIndex == 0
                                            ? "area"
                                            : selectedIndex == 1
                                                ? "city"
                                                : selectedIndex == 2
                                                    ? "organization"
                                                    : selectedIndex == 3
                                                        ? "building"
                                                        : selectedIndex == 4
                                                            ? "floor"
                                                            : selectedIndex == 5
                                                                ? "section"
                                                                : "point",
                                        onPressed: () {
                                          selectedIndex == 0
                                              ? cubit.restoreDeletedArea(cubit
                                                  .deletedAreaList!
                                                  .data![index]
                                                  .id!)
                                              : selectedIndex == 1
                                                  ? cubit.restoreDeletedCity(
                                                      cubit.deletedCityList!
                                                          .data![index].id!)
                                                  : selectedIndex == 2
                                                      ? cubit.restoreDeletedOrganization(cubit
                                                          .deletedOrganizationList!
                                                          .data![index]
                                                          .id!)
                                                      : selectedIndex == 3
                                                          ? cubit.restoreDeletedBuilding(cubit
                                                              .deletedBuildingList!
                                                              .data![index]
                                                              .id!)
                                                          : selectedIndex == 4
                                                              ? cubit.restoreDeletedFloor(cubit
                                                                  .deletedFloorList!
                                                                  .data![index]
                                                                  .id!)
                                                              : selectedIndex ==
                                                                      5
                                                                  ? cubit.restoreDeletedSection(
                                                                      cubit.deletedSectionList!.data![index].id!)
                                                                  : cubit.restoreDeletedPoint(cubit.deletedPointList!.data![index].id!);
                                        });
                                  });
                            }
                          },
                          child: Icon(
                            cubit.tapIndex == 0
                                ? Icons.mode_edit_outlined
                                : Icons.replay_outlined,
                            color: AppColor.primaryColor,
                          )),
                      horizontalSpace(10),
                      InkWell(
                          onTap: () {
                            cubit.tapIndex == 0
                                ? showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: 'delete',
                                          body: selectedIndex == 0
                                              ? "area"
                                              : selectedIndex == 1
                                                  ? "city"
                                                  : selectedIndex == 2
                                                      ? "organization"
                                                      : selectedIndex == 3
                                                          ? "building"
                                                          : selectedIndex == 4
                                                              ? "floor"
                                                              : selectedIndex ==
                                                                      5
                                                                  ? "section"
                                                                  : "point",
                                          onPressed: () {
                                            selectedIndex == 0
                                                ? cubit.deleteArea(cubit
                                                    .areaModel!
                                                    .data!
                                                    .data![index]
                                                    .id!)
                                                : selectedIndex == 1
                                                    ? cubit.deleteCity(cubit
                                                        .cityModel!
                                                        .data!
                                                        .data![index]
                                                        .id!)
                                                    : selectedIndex == 2
                                                        ? cubit.deleteOrganization(
                                                            cubit
                                                                .organizationModel!
                                                                .data!
                                                                .data![index]
                                                                .id!)
                                                        : selectedIndex == 3
                                                            ? cubit.deleteBuilding(cubit
                                                                .buildingModel!
                                                                .data!
                                                                .data![index]
                                                                .id!)
                                                            : selectedIndex == 4
                                                                ? cubit.deleteFloor(cubit
                                                                    .floorModel!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id!)
                                                                : selectedIndex ==
                                                                        5
                                                                    ? cubit.deleteSection(cubit.sectionModel!.data!.data![index].id!)
                                                                    : cubit.deletePoint(cubit.pointModel!.data!.data![index].id!);
                                          });
                                    })
                                : showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: 'delete',
                                          body: selectedIndex == 0
                                              ? "area"
                                              : selectedIndex == 1
                                                  ? "city"
                                                  : selectedIndex == 2
                                                      ? "organization"
                                                      : selectedIndex == 3
                                                          ? "building"
                                                          : selectedIndex == 4
                                                              ? "floor"
                                                              : selectedIndex ==
                                                                      5
                                                                  ? "section"
                                                                  : "point",
                                          onPressed: () {
                                            selectedIndex == 0
                                                ? cubit.forcedDeletedArea(cubit
                                                    .deletedAreaList!
                                                    .data![index]
                                                    .id!)
                                                : selectedIndex == 1
                                                    ? cubit.forcedDeletedCity(
                                                        cubit.deletedCityList!
                                                            .data![index].id!)
                                                    : selectedIndex == 2
                                                        ? cubit.forcedDeletedOrganization(
                                                            cubit
                                                                .deletedOrganizationList!
                                                                .data![index]
                                                                .id!)
                                                        : selectedIndex == 3
                                                            ? cubit.forcedDeletedBuilding(cubit
                                                                .deletedBuildingList!
                                                                .data![index]
                                                                .id!)
                                                            : selectedIndex == 4
                                                                ? cubit.forcedDeletedFloor(cubit
                                                                    .deletedFloorList!
                                                                    .data![
                                                                        index]
                                                                    .id!)
                                                                : selectedIndex ==
                                                                        5
                                                                    ? cubit.forcedDeletedSection(
                                                                        cubit.deletedSectionList!.data![index].id!)
                                                                    : cubit.forcedDeletedPoint(cubit.deletedPointList!.data![index].id!);
                                          });
                                    });
                          },
                          child: Icon(
                            IconBroken.delete,
                            color: Colors.red,
                          )),
                    ],
                  ))
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
