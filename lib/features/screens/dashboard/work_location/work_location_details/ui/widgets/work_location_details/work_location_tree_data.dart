import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/data/models/section_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationTreeData {
  final List<Map<String, String>> items;
  final List<dynamic> filteredList;
  final String currentTitle;

  WorkLocationTreeData({
    required this.items,
    required this.filteredList,
    required this.currentTitle,
  });

  factory WorkLocationTreeData.fromCubit(
    WorkLocationDetailsCubit cubit,
    int selectedIndex,
    BuildContext context,
  ) {
    switch (selectedIndex) {
      case 0: // Area
        return WorkLocationTreeData(
          items: _getAreaCounts(cubit.areaTreeModel, context),
          filteredList: _getAreaFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getAreaCounts(cubit.areaTreeModel, context).length
              ? _getAreaCounts(
                      cubit.areaTreeModel, context)[cubit.selectedTreeIndex]
                  ['title']!
              : '',
        );
      case 1: // City
        return WorkLocationTreeData(
          items: _getCityCounts(cubit.cityTreeModel, context),
          filteredList: _getCityFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getCityCounts(cubit.cityTreeModel, context).length
              ? _getCityCounts(
                      cubit.cityTreeModel, context)[cubit.selectedTreeIndex]
                  ['title']!
              : '',
        );
      case 2: // Organization
        return WorkLocationTreeData(
          items: _getOrganizationCounts(cubit.organizationTreeModel, context),
          filteredList: _getOrganizationFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getOrganizationCounts(cubit.organizationTreeModel, context)
                      .length
              ? _getOrganizationCounts(cubit.organizationTreeModel, context)[
                  cubit.selectedTreeIndex]['title']!
              : '',
        );
      case 3: // Building
        return WorkLocationTreeData(
          items: _getBuildingCounts(cubit.buildingTreeModel, context),
          filteredList: _getBuildingFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getBuildingCounts(cubit.buildingTreeModel, context).length
              ? _getBuildingCounts(
                      cubit.buildingTreeModel, context)[cubit.selectedTreeIndex]
                  ['title']!
              : '',
        );
      case 4: // Floor
        return WorkLocationTreeData(
          items: _getFloorCounts(cubit.floorTreeModel, context),
          filteredList: _getFloorFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getFloorCounts(cubit.floorTreeModel, context).length
              ? _getFloorCounts(
                      cubit.floorTreeModel, context)[cubit.selectedTreeIndex]
                  ['title']!
              : '',
        );
      case 5: // Section
        return WorkLocationTreeData(
          items: _getSectionCounts(cubit.sectionTreeModel, context),
          filteredList: _getSectionFilteredList(cubit),
          currentTitle: cubit.selectedTreeIndex <
                  _getSectionCounts(cubit.sectionTreeModel, context).length
              ? _getSectionCounts(
                      cubit.sectionTreeModel, context)[cubit.selectedTreeIndex]
                  ['title']!
              : '',
        );
      default:
        return WorkLocationTreeData(
            items: [], filteredList: [], currentTitle: '');
    }
  }

  // Area counting logic
  static List<Map<String, String>> _getAreaCounts(
      AreaTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final cityCount = model!.data!.cities?.length ?? 0;
    if (cityCount > 0)
      counts.add({"count": "$cityCount", "title": S.of(context).City});

    final organizationCount =
        model.data!.cities?.expand((city) => city.organizations ?? []).length ??
            0;
    if (organizationCount > 0) {
      counts.add(
          {"count": "$organizationCount", "title": S.of(context).Organization});
    }

    final buildingCount = model.data!.cities
            ?.expand((city) => city.organizations ?? [])
            .expand((org) => org.buildings ?? [])
            .length ??
        0;
    if (buildingCount > 0) {
      counts.add({"count": "$buildingCount", "title": S.of(context).Building});
    }

    final floorCount = model.data!.cities
            ?.expand((city) => city.organizations ?? [])
            .expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .length ??
        0;
    if (floorCount > 0) {
      counts.add({"count": "$floorCount", "title": S.of(context).Floor});
    }

    final sectionCount = model.data!.cities
            ?.expand((city) => city.organizations ?? [])
            .expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .length ??
        0;
    if (sectionCount > 0) {
      counts.add({"count": "$sectionCount", "title": S.of(context).Section});
    }

    final pointCount = model.data!.cities
            ?.expand((city) => city.organizations ?? [])
            .expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .length ??
        0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).Point});
    }

    final deviceCount = model.data!.cities
            ?.expand((city) => city.organizations ?? [])
            .expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // City counting logic
  static List<Map<String, String>> _getCityCounts(
      CityTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final organizationCount = model!.data!.organizations?.length ?? 0;
    if (organizationCount > 0) {
      counts.add(
          {"count": "$organizationCount", "title": S.of(context).Organization});
    }

    final buildingCount = model.data!.organizations
            ?.expand((org) => org.buildings ?? [])
            .length ??
        0;
    if (buildingCount > 0) {
      counts.add({"count": "$buildingCount", "title": S.of(context).Building});
    }

    final floorCount = model.data!.organizations
            ?.expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .length ??
        0;
    if (floorCount > 0) {
      counts.add({"count": "$floorCount", "title": S.of(context).Floor});
    }

    final sectionCount = model.data!.organizations
            ?.expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .length ??
        0;
    if (sectionCount > 0) {
      counts.add({"count": "$sectionCount", "title": S.of(context).Section});
    }

    final pointCount = model.data!.organizations
            ?.expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .length ??
        0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).Point});
    }

    final deviceCount = model.data!.organizations
            ?.expand((org) => org.buildings ?? [])
            .expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // Organization counting logic
  static List<Map<String, String>> _getOrganizationCounts(
      OrganizationTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final buildingCount = model!.data!.buildings?.length ?? 0;
    if (buildingCount > 0) {
      counts.add({"count": "$buildingCount", "title": S.of(context).Building});
    }

    final floorCount = model.data!.buildings
            ?.expand((building) => building.floors ?? [])
            .length ??
        0;
    if (floorCount > 0) {
      counts.add({"count": "$floorCount", "title": S.of(context).Floor});
    }

    final sectionCount = model.data!.buildings
            ?.expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .length ??
        0;
    if (sectionCount > 0) {
      counts.add({"count": "$sectionCount", "title": S.of(context).Section});
    }

    final pointCount = model.data!.buildings
            ?.expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .length ??
        0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).Point});
    }

    final deviceCount = model.data!.buildings
            ?.expand((building) => building.floors ?? [])
            .expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // Building counting logic
  static List<Map<String, String>> _getBuildingCounts(
      BuildingTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final floorCount = model!.data!.floors?.length ?? 0;
    if (floorCount > 0) {
      counts.add({"count": "$floorCount", "title": S.of(context).Floor});
    }

    final sectionCount =
        model.data!.floors?.expand((floor) => floor.sections ?? []).length ?? 0;
    if (sectionCount > 0) {
      counts.add({"count": "$sectionCount", "title": S.of(context).City});
    }

    final pointCount = model.data!.floors
            ?.expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .length ??
        0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).City});
    }

    final deviceCount = model.data!.floors
            ?.expand((floor) => floor.sections ?? [])
            .expand((section) => section.points ?? [])
            .expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // Floor counting logic
  static List<Map<String, String>> _getFloorCounts(
      FloorTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final sectionCount = model!.data!.sections?.length ?? 0;
    if (sectionCount > 0) {
      counts.add({"count": "$sectionCount", "title": S.of(context).City});
    }

    final pointCount = model.data!.sections
            ?.expand((section) => section.points ?? [])
            .length ??
        0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).City});
    }

    final deviceCount = model.data!.sections
            ?.expand((section) => section.points ?? [])
            .expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // Section counting logic
  static List<Map<String, String>> _getSectionCounts(
      SectionTreeModel? model, BuildContext context) {
    List<Map<String, String>> counts = [];
    if (model?.data == null) return counts;

    final pointCount = model!.data!.points?.length ?? 0;
    if (pointCount > 0) {
      counts.add({"count": "$pointCount", "title": S.of(context).City});
    }

    final deviceCount = model.data!.points
            ?.expand((point) => point.device != null ? [point.device!] : [])
            .length ??
        0;
    if (deviceCount > 0) {
      counts.add({"count": "$deviceCount", "title": S.of(context).device});
    }

    return counts;
  }

  // Area filtering logic
  static List<dynamic> _getAreaFilteredList(WorkLocationDetailsCubit cubit) {
    final areaTreeModel = cubit.areaTreeModel;
    if (areaTreeModel == null || areaTreeModel.data == null) return [];

    switch (cubit.selectedTreeIndex) {
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
                .expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  // City filtering logic
  static List<dynamic> _getCityFilteredList(WorkLocationDetailsCubit cubit) {
    final cityTreeModel = cubit.cityTreeModel;
    if (cityTreeModel == null || cityTreeModel.data == null) return [];

    switch (cubit.selectedTreeIndex) {
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
                .expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  // Organization filtering logic
  static List<dynamic> _getOrganizationFilteredList(
      WorkLocationDetailsCubit cubit) {
    final organizationTreeModel = cubit.organizationTreeModel;
    if (organizationTreeModel == null || organizationTreeModel.data == null)
      return [];

    switch (cubit.selectedTreeIndex) {
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
                .expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  // Building filtering logic
  static List<dynamic> _getBuildingFilteredList(
      WorkLocationDetailsCubit cubit) {
    final buildingTreeModel = cubit.buildingTreeModel;
    if (buildingTreeModel == null || buildingTreeModel.data == null) return [];

    switch (cubit.selectedTreeIndex) {
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
                .expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  // Floor filtering logic
  static List<dynamic> _getFloorFilteredList(WorkLocationDetailsCubit cubit) {
    final floorTreeModel = cubit.floorTreeModel;
    if (floorTreeModel == null || floorTreeModel.data == null) return [];

    switch (cubit.selectedTreeIndex) {
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
                .expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  // Section filtering logic
  static List<dynamic> _getSectionFilteredList(WorkLocationDetailsCubit cubit) {
    final sectionTreeModel = cubit.sectionTreeModel;
    if (sectionTreeModel == null || sectionTreeModel.data == null) return [];

    switch (cubit.selectedTreeIndex) {
      case 0: // Point
        return sectionTreeModel.data!.points ?? [];
      case 1: // Device
        return sectionTreeModel.data!.points
                ?.expand((point) => point.device != null ? [point.device!] : [])
                .toList() ??
            [];
      default:
        return [];
    }
  }
}
