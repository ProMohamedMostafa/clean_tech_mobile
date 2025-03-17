class UserWorkLocationDetailsModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final DataModel data;

  UserWorkLocationDetailsModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.data,
  });

  factory UserWorkLocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserWorkLocationDetailsModel(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      message: json['message'] ?? '',
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel {
  final List<AreaModel> areas;
  final List<CityModel> cities;
  final List<OrganizationModel> organizations;
  final List<BuildingModel> buildings;
  final List<FloorModel> floors;
  final List<SectionModel> sections;
  final List<PointModel> points;

  DataModel({
    required this.areas,
    required this.cities,
    required this.organizations,
    required this.buildings,
    required this.floors,
    required this.sections,
    required this.points,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      areas: (json['areas'] as List).map((e) => AreaModel.fromJson(e)).toList(),
      cities:
          (json['cities'] as List).map((e) => CityModel.fromJson(e)).toList(),
      organizations: (json['organizations'] as List)
          .map((e) => OrganizationModel.fromJson(e))
          .toList(),
      buildings: (json['buildings'] as List)
          .map((e) => BuildingModel.fromJson(e))
          .toList(),
      floors:
          (json['floors'] as List).map((e) => FloorModel.fromJson(e)).toList(),
      sections: (json['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
      points:
          (json['points'] as List).map((e) => PointModel.fromJson(e)).toList(),
    );
  }
}

class AreaModel {
  final int id;
  final String name;
  final String countryName;

  AreaModel({required this.id, required this.name, required this.countryName});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      name: json['name'],
      countryName: json['countryName'],
    );
  }
}

class CityModel {
  final int id;
  final String name;
  final int areaId;
  final String areaName;
  final String countryName;

  CityModel(
      {required this.id,
      required this.name,
      required this.areaId,
      required this.areaName,
      required this.countryName});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}

class OrganizationModel {
  final int id;
  final String name;
  final int cityId;
  final String cityName;
  final int areaId;
  final String areaName;
  final String countryName;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.countryName,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'],
      name: json['name'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}

class BuildingModel {
  final int id;
  final String name;
  final String number;
  final String description;
  final int organizationId;
  final String organizationName;
  final int cityId;
  final String cityName;
  final int areaId;
  final String areaName;
  final String countryName;

  BuildingModel({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.organizationId,
    required this.organizationName,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.countryName,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}

class FloorModel {
  final int id;
  final String name;
  final String number;
  final String description;
  final int buildingId;
  final String buildingName;
  final int organizationId;
  final String organizationName;
  final int cityId;
  final String cityName;
  final int areaId;
  final String areaName;
  final String countryName;

  FloorModel({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.buildingId,
    required this.buildingName,
    required this.organizationId,
    required this.organizationName,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.countryName,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      buildingId: json['buildingId'],
      buildingName: json['buildingName'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}

class SectionModel {
  final int id;
  final String name;
  final String number;
  final String description;
  final int floorId;
  final String floorName;
  final int buildingId;
  final String buildingName;
  final int organizationId;
  final String organizationName;
  final int cityId;
  final String cityName;
  final int areaId;
  final String areaName;
  final String countryName;

  SectionModel({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.floorId,
    required this.floorName,
    required this.buildingId,
    required this.buildingName,
    required this.organizationId,
    required this.organizationName,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.countryName,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      floorId: json['floorId'],
      floorName: json['floorName'],
      buildingId: json['buildingId'],
      buildingName: json['buildingName'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}

class PointModel {
  final int id;
  final String name;
  final String number;
  final String description;
  final bool isCountable;
  final String? capacity;
  final String unit;
  final int sectionId;
  final String sectionName;
  final int floorId;
  final String floorName;
  final int buildingId;
  final String buildingName;
  final int organizationId;
  final String organizationName;
  final int cityId;
  final String cityName;
  final int areaId;
  final String areaName;
  final String countryName;

  PointModel({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.isCountable,
    this.capacity,
    required this.unit,
    required this.sectionId,
    required this.sectionName,
    required this.floorId,
    required this.floorName,
    required this.buildingId,
    required this.buildingName,
    required this.organizationId,
    required this.organizationName,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.countryName,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      isCountable: json['isCountable'],
      capacity: json['capacity'],
      unit: json['unit'],
      sectionId: json['sectionId'],
      sectionName: json['sectionName'],
      floorId: json['floorId'],
      floorName: json['floorName'],
      buildingId: json['buildingId'],
      buildingName: json['buildingName'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}
