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

class DeleteWorkLocationListItem extends StatelessWidget {
  final int selectedIndex;
  final int index;
  const DeleteWorkLocationListItem(
      {super.key, required this.selectedIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationCubit>();
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
                                  ? cubit.deletedSectionList!.data![index].name!
                                  : cubit.deletedPointList!.data![index].name!,
          style: TextStyles.font14BlackSemiBold,
        ),
        subtitle: Text(
          selectedIndex == 0
              ? cubit.deletedAreaList!.data![index].countryName!
              : selectedIndex == 1
                  ? cubit.deletedCityList!.data![index].areaName!
                  : selectedIndex == 2
                      ? cubit.deletedOrganizationList!.data![index].cityName!
                      : selectedIndex == 3
                          ? cubit.deletedBuildingList!.data![index]
                              .organizationName!
                          : selectedIndex == 4
                              ? cubit
                                  .deletedFloorList!.data![index].buildingName!
                              : selectedIndex == 5
                                  ? cubit.deletedSectionList!.data![index]
                                      .floorName!
                                  : cubit.deletedPointList!.data![index]
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
                      showCustomDialog(context, "Are you Sure to restore ?",
                          () {
                        selectedIndex == 0
                            ? cubit.restoreDeletedArea(
                                cubit.deletedAreaList!.data![index].id!)
                            : selectedIndex == 1
                                ? cubit.restoreDeletedCity(
                                    cubit.deletedCityList!.data![index].id!)
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
                                            : selectedIndex == 5
                                                ? cubit.restoreDeletedSection(
                                                    cubit.deletedSectionList!
                                                        .data![index].id!)
                                                : cubit.restoreDeletedPoint(cubit
                                                    .deletedPointList!
                                                    .data![index]
                                                    .id!);
                        context.pop();
                      });
                    },
                    child: Icon(
                      Icons.replay_outlined,
                      color: AppColor.primaryColor,
                    )),
                horizontalSpace(10),
                InkWell(
                    onTap: () {
                      showCustomDialog(context, "Forced Delete ?", () {
                        selectedIndex == 0
                            ? cubit.forcedDeletedArea(
                                cubit.deletedAreaList!.data![index].id!)
                            : selectedIndex == 1
                                ? cubit.forcedDeletedCity(
                                    cubit.deletedCityList!.data![index].id!)
                                : selectedIndex == 2
                                    ? cubit.forcedDeletedOrganization(cubit
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
                                                .data![index]
                                                .id!)
                                            : selectedIndex == 5
                                                ? cubit.forcedDeletedSection(
                                                    cubit.deletedSectionList!
                                                        .data![index].id!)
                                                : cubit.forcedDeletedPoint(cubit
                                                    .deletedPointList!
                                                    .data![index]
                                                    .id!);
                        context.pop();
                      });
                    },
                    child: Icon(
                      IconBroken.delete,
                      color: Colors.red,
                    )),
              ],
            )),
      ),
    );
  }
}
