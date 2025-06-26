import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/section_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';

class WorkLocationTree extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationTree({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    List<Map<String, String>> items;
    List<dynamic> filteredList;

    List<Map<String, String>> getAreaCountsFromModel(AreaTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int cityCount = model.data!.cities?.length ?? 0;
        if (cityCount > 0) {
          counts.add({"count": "$cityCount", "title": "City"});
        }

        int organizationCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .length ??
            0;
        if (organizationCount > 0) {
          counts.add({"count": "$organizationCount", "title": "Organization"});
        }

        int buildingCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .length ??
            0;
        if (buildingCount > 0) {
          counts.add({"count": "$buildingCount", "title": "Building"});
        }

        int floorCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .length ??
            0;
        if (floorCount > 0) {
          counts.add({"count": "$floorCount", "title": "Floor"});
        }

        int sectionCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .length ??
            0;
        if (sectionCount > 0) {
          counts.add({"count": "$sectionCount", "title": "Section"});
        }
        int pointCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .length ??
            0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<Map<String, String>> getCityCountsFromModel(CityTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int organizationCount = model.data!.organizations?.length ?? 0;
        if (organizationCount > 0) {
          counts.add({"count": "$organizationCount", "title": "Organization"});
        }

        int buildingCount = model.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .length ??
            0;
        if (buildingCount > 0) {
          counts.add({"count": "$buildingCount", "title": "Building"});
        }

        int floorCount = model.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .length ??
            0;
        if (floorCount > 0) {
          counts.add({"count": "$floorCount", "title": "Floor"});
        }

        int sectionCount = model.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .length ??
            0;
        if (sectionCount > 0) {
          counts.add({"count": "$sectionCount", "title": "Section"});
        }

        int pointCount = model.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .length ??
            0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<Map<String, String>> getOrganizationCountsFromModel(
        OrganizationTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int buildingCount = model.data!.buildings?.length ?? 0;
        if (buildingCount > 0) {
          counts.add({"count": "$buildingCount", "title": "Building"});
        }

        int floorCount = model.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .length ??
            0;
        if (floorCount > 0) {
          counts.add({"count": "$floorCount", "title": "Floor"});
        }

        int sectionCount = model.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .length ??
            0;
        if (sectionCount > 0) {
          counts.add({"count": "$sectionCount", "title": "Section"});
        }

        int pointCount = model.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .length ??
            0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<Map<String, String>> getBuildingCountsFromModel(
        BuildingTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int floorCount = model.data!.floors?.length ?? 0;
        if (floorCount > 0) {
          counts.add({"count": "$floorCount", "title": "Floor"});
        }

        int sectionCount = model.data!.floors
                ?.expand((floor) => floor.sections ?? [])
                .length ??
            0;
        if (sectionCount > 0) {
          counts.add({"count": "$sectionCount", "title": "Section"});
        }

        int pointCount = model.data!.floors
                ?.expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .length ??
            0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.floors
                ?.expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<Map<String, String>> getFloorCountsFromModel(FloorTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int sectionCount = model.data!.sections?.length ?? 0;
        if (sectionCount > 0) {
          counts.add({"count": "$sectionCount", "title": "Section"});
        }

        int pointCount = model.data!.sections
                ?.expand((section) => section.points ?? [])
                .length ??
            0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.sections
                ?.expand((section) => section.points ?? [])
                .expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<Map<String, String>> getSectionCountsFromModel(
        SectionTreeModel model) {
      List<Map<String, String>> counts = [];

      if (model.data != null) {
        int pointCount = model.data!.points?.length ?? 0;
        if (pointCount > 0) {
          counts.add({"count": "$pointCount", "title": "Point"});
        }
        int deviceCount = model.data!.points
                ?.expand((point) => point.device != null ? [point.device!] : [])
                .length ??
            0;
        if (deviceCount > 0) {
          counts.add({"count": "$deviceCount", "title": "Device"});
        }
      }

      return counts;
    }

    List<dynamic> getAreaFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final areaTreeModel = cubit.areaTreeModel;
      if (areaTreeModel == null || areaTreeModel.data == null) return [];

      switch (selectedIndex) {
        case 0: // City
          return areaTreeModel.data!.cities ?? [];
        case 1: // Organization
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .toList() ??
              [];
        case 2: // Building
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .expand((org) => org.buildings ?? [])
                  .toList() ??
              [];
        case 3: // Floor
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .toList() ??
              [];
        case 4: // Section
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .toList() ??
              [];
        case 5: // Point
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .toList() ??
              [];
        case 6: // Device
          return areaTreeModel.data!.cities
                  ?.expand((city) => city.organizations ?? [])
                  .expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    List<dynamic> getCityFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final cityTreeModel = cubit.cityTreeModel;
      if (cityTreeModel == null || cityTreeModel.data == null) return [];

      switch (selectedIndex) {
        case 0: // Organization
          return cityTreeModel.data!.organizations ?? [];
        case 1: // Building
          return cityTreeModel.data!.organizations
                  ?.expand((org) => org.buildings ?? [])
                  .toList() ??
              [];
        case 2: // Floor
          return cityTreeModel.data!.organizations
                  ?.expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .toList() ??
              [];
        case 3: // Section
          return cityTreeModel.data!.organizations
                  ?.expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .toList() ??
              [];
        case 4: // Point
          return cityTreeModel.data!.organizations
                  ?.expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .toList() ??
              [];
        case 5: // Device
          return cityTreeModel.data!.organizations
                  ?.expand((org) => org.buildings ?? [])
                  .expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    List<dynamic> getOrganizationFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final organizationTreeModel = cubit.organizationTreeModel;
      if (organizationTreeModel == null || organizationTreeModel.data == null)
        return [];

      switch (selectedIndex) {
        case 0: // Building
          return organizationTreeModel.data!.buildings ?? [];
        case 1: // Floor
          return organizationTreeModel.data!.buildings
                  ?.expand((building) => building.floors ?? [])
                  .toList() ??
              [];
        case 2: // Section
          return organizationTreeModel.data!.buildings
                  ?.expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .toList() ??
              [];
        case 3: // Point
          return organizationTreeModel.data!.buildings
                  ?.expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .toList() ??
              [];
        case 4: // Device
          return organizationTreeModel.data!.buildings
                  ?.expand((building) => building.floors ?? [])
                  .expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    List<dynamic> getBuildingFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final buildingTreeModel = cubit.buildingTreeModel;
      if (buildingTreeModel == null || buildingTreeModel.data == null)
        return [];

      switch (selectedIndex) {
        case 0: // Floor
          return buildingTreeModel.data!.floors ?? [];
        case 1: // Section
          return buildingTreeModel.data!.floors
                  ?.expand((floor) => floor.sections ?? [])
                  .toList() ??
              [];
        case 2: // Point
          return buildingTreeModel.data!.floors
                  ?.expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .toList() ??
              [];
        case 3: // Device
          return buildingTreeModel.data!.floors
                  ?.expand((floor) => floor.sections ?? [])
                  .expand((section) => section.points ?? [])
                  .expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    List<dynamic> getFloorFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final floorTreeModel = cubit.floorTreeModel;
      if (floorTreeModel == null || floorTreeModel.data == null) return [];

      switch (selectedIndex) {
        case 0: // Section
          return floorTreeModel.data!.sections ?? [];
        case 1: // Point
          return floorTreeModel.data!.sections
                  ?.expand((section) => section.points ?? [])
                  .toList() ??
              [];
        case 2: // Device
          return floorTreeModel.data!.sections
                  ?.expand((section) => section.points ?? [])
                  .expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    List<dynamic> getSectionFilteredList(
        WorkLocationDetailsCubit cubit, int selectedIndex) {
      final sectionTreeModel = cubit.sectionTreeModel;
      if (sectionTreeModel == null || sectionTreeModel.data == null) return [];

      switch (selectedIndex) {
        case 0: // Point
          return sectionTreeModel.data!.points ?? [];
        case 1: // Device
          return sectionTreeModel.data!.points
                  ?.expand(
                      (point) => point.device != null ? [point.device!] : [])
                  .toList() ??
              [];
        default:
          return [];
      }
    }

    switch (selectedIndex) {
      case 0:
        items = getAreaCountsFromModel(cubit.areaTreeModel!);
        filteredList = getAreaFilteredList(cubit, cubit.selectedTreeIndex);
        break;
      case 1:
        items = getCityCountsFromModel(cubit.cityTreeModel!);
        filteredList = getCityFilteredList(cubit, cubit.selectedTreeIndex);
        break;
      case 2:
        items = getOrganizationCountsFromModel(cubit.organizationTreeModel!);
        filteredList =
            getOrganizationFilteredList(cubit, cubit.selectedTreeIndex);
        break;
      case 3:
        items = getBuildingCountsFromModel(cubit.buildingTreeModel!);
        filteredList = getBuildingFilteredList(cubit, cubit.selectedTreeIndex);
        break;
      case 4:
        items = getFloorCountsFromModel(cubit.floorTreeModel!);
        filteredList = getFloorFilteredList(cubit, cubit.selectedTreeIndex);
        break;
      case 5:
        items = getSectionCountsFromModel(cubit.sectionTreeModel!);
        filteredList = getSectionFilteredList(cubit, cubit.selectedTreeIndex);
        break;

      default:
        items = [];
        filteredList = [];
    }
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              bool isSelected = index == cubit.selectedTreeIndex;
              return GestureDetector(
                onTap: () {
                  cubit.changeSelectedTreeIndex(index);
                },
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${items[index]['count']} ${items[index]['title']}",
                          style: TextStyle(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp),
                        ),
                        if (isSelected)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            height: 2.h,
                            color: AppColor.primaryColor,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: filteredList.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            final item = filteredList[index];
            final currentTitle = cubit.selectedTreeIndex < items.length
                ? items[cubit.selectedTreeIndex]['title']!
                : '';

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    final levelIndex = {
                      'City': 1,
                      'Organization': 2,
                      'Building': 3,
                      'Floor': 4,
                      'Section': 5,
                      'Point': 6,
                      'Device': 7,
                    };

                    context.pushNamed(Routes.workLocationDetailsScreen,
                        arguments: {
                          'id': item.id!,
                          'selectedIndex': levelIndex[currentTitle]
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      minTileHeight: 72.h,
                      title: Text(
                        item.name ?? '',
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      subtitle: currentTitle != "Device"
                          ? Text(
                              item.previousName ?? '',
                              style: TextStyles.font12GreyRegular,
                            )
                          : null,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColor.thirdColor,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    ));
  }
}
