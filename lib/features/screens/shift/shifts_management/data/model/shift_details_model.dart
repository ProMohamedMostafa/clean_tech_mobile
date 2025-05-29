class ShiftDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  ShiftData? data;

  ShiftDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory ShiftDetailsModel.fromJson(Map<String?, dynamic> json) {
    return ShiftDetailsModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: ShiftData.fromJson(json['data']),
    );
  }
}

class ShiftData {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  List<Organization>? organizations;
  List<Building>? building;
  List<Floor>? floors;
  List<Section>? sections;

  ShiftData({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.organizations,
    this.building,
    this.floors,
    this.sections,
  });

  factory ShiftData.fromJson(Map<String?, dynamic> json) {
    return ShiftData(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      organizations: (json['organizations'] as List)
          .map((e) => Organization.fromJson(e))
          .toList(),
      building:
          (json['building'] as List).map((e) => Building.fromJson(e)).toList(),
      floors: (json['floors'] as List).map((e) => Floor.fromJson(e)).toList(),
      sections:
          (json['sections'] as List).map((e) => Section.fromJson(e)).toList(),
    );
  }
}

class Organization {
  int? id;
  String? name;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  Organization({
    this.id,
    this.name,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory Organization.fromJson(Map<String?, dynamic> json) {
    return Organization(
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

class Building {
  int? id;
  String? name;
  String? number;
  String? description;
  int? organizationId;
  String? organizationName;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  Building({
    this.id,
    this.name,
    this.number,
    this.description,
    this.organizationId,
    this.organizationName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory Building.fromJson(Map<String?, dynamic> json) {
    return Building(
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

class Floor {
  int? id;
  String? name;
  String? number;
  String? description;
  int? buildingId;
  String? buildingName;
  int? organizationId;
  String? organizationName;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  Floor({
    this.id,
    this.name,
    this.number,
    this.description,
    this.buildingId,
    this.buildingName,
    this.organizationId,
    this.organizationName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory Floor.fromJson(Map<String?, dynamic> json) {
    return Floor(
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

class Section {
  int? id;
  String? name;
  String? number;
  String? description;
  int? floorId;
  String? floorName;
  int? buildingId;
  String? buildingName;
  int? organizationId;
  String? organizationName;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  Section({
    this.id,
    this.name,
    this.number,
    this.description,
    this.floorId,
    this.floorName,
    this.buildingId,
    this.buildingName,
    this.organizationId,
    this.organizationName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory Section.fromJson(Map<String?, dynamic> json) {
    return Section(
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
