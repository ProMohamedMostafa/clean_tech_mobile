import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/logic/delete_organization_cubit.dart';

Widget deleteOrganizationsListItemBuild(
    BuildContext context, selectedIndex, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                selectedIndex == 0
                    ? context
                        .read<DeleteOrganizationsCubit>()
                        .deletedAreaList!
                        .data![index]
                        .name!
                    : selectedIndex == 1
                        ? context
                            .read<DeleteOrganizationsCubit>()
                            .deletedCityList!
                            .data![index]
                            .name!
                        : selectedIndex == 2
                            ? context
                                .read<DeleteOrganizationsCubit>()
                                .deletedOrganizationList!
                                .data![index]
                                .name!
                            : selectedIndex == 3
                                ? context
                                    .read<DeleteOrganizationsCubit>()
                                    .deletedBuildingList!
                                    .data![index]
                                    .name!
                                : selectedIndex == 4
                                    ? context
                                        .read<DeleteOrganizationsCubit>()
                                        .deletedFloorList!
                                        .data![index]
                                        .name!
                                    : context
                                        .read<DeleteOrganizationsCubit>()
                                        .deletedPointList!
                                        .data![index]
                                        .name!,
                style: TextStyles.font14BlackSemiBold,
              ),
              Text(
                selectedIndex == 0
                    ? context
                        .read<DeleteOrganizationsCubit>()
                        .deletedAreaList!
                        .data![index]
                        .countryName!
                    : selectedIndex == 1
                        ? context
                            .read<DeleteOrganizationsCubit>()
                            .deletedCityList!
                            .data![index]
                            .areaName!
                        : selectedIndex == 2
                            ? context
                                .read<DeleteOrganizationsCubit>()
                                .deletedOrganizationList!
                                .data![index]
                                .cityName!
                            : selectedIndex == 3
                                ? context
                                    .read<DeleteOrganizationsCubit>()
                                    .deletedBuildingList!
                                    .data![index]
                                    .organizationName!
                                : selectedIndex == 4
                                    ? context
                                        .read<DeleteOrganizationsCubit>()
                                        .deletedFloorList!
                                        .data![index]
                                        .buildingName!
                                    : context
                                        .read<DeleteOrganizationsCubit>()
                                        .deletedPointList!
                                        .data![index]
                                        .floorName!,
                style: TextStyles.font12GreyRegular,
              ),
            ],
          ),
        ],
      ),
      Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                showCustomDialog(context, "Are you Sure to restore this user ?",
                    () {
                  selectedIndex == 0
                      ? context
                          .read<DeleteOrganizationsCubit>()
                          .restoreDeletedArea(context
                              .read<DeleteOrganizationsCubit>()
                              .deletedAreaList!
                              .data![index]
                              .id!)
                      : selectedIndex == 1
                          ? context
                              .read<DeleteOrganizationsCubit>()
                              .restoreDeletedCity(context
                                  .read<DeleteOrganizationsCubit>()
                                  .deletedCityList!
                                  .data![index]
                                  .id!)
                          : selectedIndex == 2
                              ? context
                                  .read<DeleteOrganizationsCubit>()
                                  .restoreDeletedOrganization(context
                                      .read<DeleteOrganizationsCubit>()
                                      .deletedOrganizationList!
                                      .data![index]
                                      .id!)
                              : selectedIndex == 3
                                  ? context
                                      .read<DeleteOrganizationsCubit>()
                                      .restoreDeletedBuilding(context
                                          .read<DeleteOrganizationsCubit>()
                                          .deletedBuildingList!
                                          .data![index]
                                          .id!)
                                  : selectedIndex == 4
                                      ? context
                                          .read<DeleteOrganizationsCubit>()
                                          .restoreDeletedFloor(context
                                              .read<DeleteOrganizationsCubit>()
                                              .deletedFloorList!
                                              .data![index]
                                              .id!)
                                      : context
                                          .read<DeleteOrganizationsCubit>()
                                          .restoreDeletedPoint(context
                                              .read<DeleteOrganizationsCubit>()
                                              .deletedPointList!
                                              .data![index]
                                              .id!);
                  context.pop();
                });
              },
              child: Icon(
                Icons.replay_outlined,
                color: AppColor.thirdColor,
              )),
          horizontalSpace(10),
          InkWell(
              onTap: () {
                showCustomDialog(context, "Forced Delete this user", () {
                  
                          selectedIndex == 0
                      ? context.read<DeleteOrganizationsCubit>().forcedDeletedArea(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedAreaList!
                          .data![index]
                          .id!)
                      : selectedIndex == 1
                          ? context.read<DeleteOrganizationsCubit>().forcedDeletedCity(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedCityList!
                          .data![index]
                          .id!)
                          : selectedIndex == 2
                              ? context.read<DeleteOrganizationsCubit>().forcedDeletedOrganization(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedOrganizationList!
                          .data![index]
                          .id!)
                              : selectedIndex == 3
                                  ? context.read<DeleteOrganizationsCubit>().forcedDeletedBuilding(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedBuildingList!
                          .data![index]
                          .id!)
                                  : selectedIndex == 4
                                      ? context.read<DeleteOrganizationsCubit>().forcedDeletedFloor(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedFloorList!
                          .data![index]
                          .id!)
                                      : context.read<DeleteOrganizationsCubit>().forcedDeletedPoint(
                      context
                          .read<DeleteOrganizationsCubit>()
                          .deletedPointList!
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
      )
    ],
  );
}
