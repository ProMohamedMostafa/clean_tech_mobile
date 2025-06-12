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
      onTap: () {
        context.pushNamed(Routes.workLocationDetailsScreen, arguments: {
          'id': selectedIndex == 0
              ? cubit.areaModel!.data!.data![index].id!.toInt()
              : selectedIndex == 1
                  ? cubit.cityModel!.data!.data![index].id!.toInt()
                  : selectedIndex == 2
                      ? cubit.organizationModel!.data!.data![index].id!.toInt()
                      : selectedIndex == 3
                          ? cubit.buildingModel!.data!.data![index].id!.toInt()
                          : selectedIndex == 4
                              ? cubit.floorModel!.data!.data![index].id!.toInt()
                              : selectedIndex == 5
                                  ? cubit.sectionModel!.data!.data![index].id!
                                      .toInt()
                                  : cubit.pointModel!.data!.data![index].id!
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
                                    ? cubit
                                        .sectionModel!.data!.data![index].name!
                                    : cubit
                                        .pointModel!.data!.data![index].name!,
            style: TextStyles.font14Primarybold,
          ),
          subtitle: Text(
            selectedIndex == 0
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
                                    : "${cubit.pointModel!.data!.data![index].sectionName}",
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
                                                        ? Routes
                                                            .editSectionScreen
                                                        : Routes
                                                            .editPointScreen,
                                arguments: selectedIndex == 0
                                    ? cubit.areaModel!.data!.data![index].id
                                    : selectedIndex == 1
                                        ? cubit.cityModel!.data!.data![index].id
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
                          },
                          child: Icon(
                            Icons.mode_edit_outlined,
                            color: AppColor.primaryColor,
                          )),
                      horizontalSpace(10),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return PopUpMeassage(
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
                                                          : selectedIndex == 5
                                                              ? "section"
                                                              : "point",
                                      onPressed: () {
                                        selectedIndex == 0
                                            ? cubit.deleteArea(cubit.areaModel!
                                                .data!.data![index].id!)
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
                                                        ? cubit.deleteBuilding(
                                                            cubit
                                                                .buildingModel!
                                                                .data!
                                                                .data![index]
                                                                .id!)
                                                        : selectedIndex == 4
                                                            ? cubit.deleteFloor(
                                                                cubit
                                                                    .floorModel!
                                                                    .data!
                                                                    .data![index]
                                                                    .id!)
                                                            : selectedIndex == 5
                                                                ? cubit.deleteSection(cubit.sectionModel!.data!.data![index].id!)
                                                                : cubit.deletePoint(cubit.pointModel!.data!.data![index].id!);
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
