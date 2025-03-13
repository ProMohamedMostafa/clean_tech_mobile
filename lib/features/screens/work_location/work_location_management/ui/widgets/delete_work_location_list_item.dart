import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget deleteOrganizationsListItemBuild(
    BuildContext context, selectedIndex, index) {
  return Card(
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
        Icons.place,
        color: AppColor.primaryColor,
      ),
      title: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .deletedAreaList!
                .data![index]
                .name!
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .deletedCityList!
                    .data![index]
                    .name!
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .deletedOrganizationList!
                        .data![index]
                        .name!
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .deletedBuildingList!
                            .data![index]
                            .name!
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .deletedFloorList!
                                .data![index]
                                .name!
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .deletedSectionList!
                                    .data![index]
                                    .name!
                                : context
                                    .read<WorkLocationCubit>()
                                    .deletedPointList!
                                    .data![index]
                                    .name!,
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .deletedAreaList!
                .data![index]
                .countryName!
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .deletedCityList!
                    .data![index]
                    .areaName!
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .deletedOrganizationList!
                        .data![index]
                        .cityName!
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .deletedBuildingList!
                            .data![index]
                            .organizationName!
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .deletedFloorList!
                                .data![index]
                                .buildingName!
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .deletedSectionList!
                                    .data![index]
                                    .floorName!
                                : context
                                    .read<WorkLocationCubit>()
                                    .deletedPointList!
                                    .data![index]
                                    .sectionName!,
        style: TextStyles.font12GreyRegular,
      ),
      trailing: SizedBox(
          width: 80.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    showCustomDialog(context, "Are you Sure to restore ?", () {
                      selectedIndex == 0
                          ? context
                              .read<WorkLocationCubit>()
                              .restoreDeletedArea(context
                                  .read<WorkLocationCubit>()
                                  .deletedAreaList!
                                  .data![index]
                                  .id!)
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationCubit>()
                                  .restoreDeletedCity(context
                                      .read<WorkLocationCubit>()
                                      .deletedCityList!
                                      .data![index]
                                      .id!)
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .restoreDeletedOrganization(context
                                          .read<WorkLocationCubit>()
                                          .deletedOrganizationList!
                                          .data![index]
                                          .id!)
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .restoreDeletedBuilding(context
                                              .read<WorkLocationCubit>()
                                              .deletedBuildingList!
                                              .data![index]
                                              .id!)
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .restoreDeletedFloor(context
                                                  .read<WorkLocationCubit>()
                                                  .deletedFloorList!
                                                  .data![index]
                                                  .id!)
                                          : selectedIndex == 5
                                              ? context
                                                  .read<WorkLocationCubit>()
                                                  .restoreDeletedSection(context
                                                      .read<WorkLocationCubit>()
                                                      .deletedSectionList!
                                                      .data![index]
                                                      .id!)
                                              : context
                                                  .read<WorkLocationCubit>()
                                                  .restoreDeletedPoint(context
                                                      .read<WorkLocationCubit>()
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
                    showCustomDialog(context, "Forced Delete ?", () {
                      selectedIndex == 0
                          ? context.read<WorkLocationCubit>().forcedDeletedArea(
                              context
                                  .read<WorkLocationCubit>()
                                  .deletedAreaList!
                                  .data![index]
                                  .id!)
                          : selectedIndex == 1
                              ? context
                                  .read<WorkLocationCubit>()
                                  .forcedDeletedCity(context
                                      .read<WorkLocationCubit>()
                                      .deletedCityList!
                                      .data![index]
                                      .id!)
                              : selectedIndex == 2
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .forcedDeletedOrganization(context
                                          .read<WorkLocationCubit>()
                                          .deletedOrganizationList!
                                          .data![index]
                                          .id!)
                                  : selectedIndex == 3
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .forcedDeletedBuilding(context
                                              .read<WorkLocationCubit>()
                                              .deletedBuildingList!
                                              .data![index]
                                              .id!)
                                      : selectedIndex == 4
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .forcedDeletedFloor(context
                                                  .read<WorkLocationCubit>()
                                                  .deletedFloorList!
                                                  .data![index]
                                                  .id!)
                                          :selectedIndex == 5
                                                  ? context
                                              .read<WorkLocationCubit>()
                                              .forcedDeletedSection(context
                                                  .read<WorkLocationCubit>()
                                                  .deletedSectionList!
                                                  .data![index]
                                                  .id!): context
                                              .read<WorkLocationCubit>()
                                              .forcedDeletedPoint(context
                                                  .read<WorkLocationCubit>()
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
          )),
    ),
  );
}
