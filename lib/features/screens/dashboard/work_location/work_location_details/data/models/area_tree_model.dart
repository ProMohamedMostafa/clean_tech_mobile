class AreaTreeModel {
  final int? statusCode;
  final dynamic meta;
  final bool? succeeded;
  final String? message;
  final dynamic error;
  final dynamic businessErrorCode;
  final AreaTreeData? data;

  AreaTreeModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory AreaTreeModel.fromJson(Map<String, dynamic> json) => AreaTreeModel(
        statusCode: json['statusCode'],
        meta: json['meta'],
        succeeded: json['succeeded'],
        message: json['message'],
        error: json['error'],
        businessErrorCode: json['businessErrorCode'],
        data: json['data'] == null ? null : AreaTreeData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'meta': meta,
        'succeeded': succeeded,
        'message': message,
        'error': error,
        'businessErrorCode': businessErrorCode,
        'data': data?.toJson(),
      };
}

class AreaTreeData {
  final int? id;
  final String? name;
  final String? previousName;
  final List<City>? cities;

  AreaTreeData({
    this.id,
    this.name,
    this.previousName,
    this.cities,
  });

  factory AreaTreeData.fromJson(Map<String, dynamic> json) => AreaTreeData(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        cities: json['cities'] == null
            ? null
            : List<City>.from(json['cities'].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'cities': cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Organization>? organizations;

  City({
    this.id,
    this.name,
    this.previousName,
    this.organizations,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        organizations: json['organizations'] == null
            ? null
            : List<Organization>.from(
                json['organizations'].map((x) => Organization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'organizations': organizations == null
            ? null
            : List<dynamic>.from(organizations!.map((x) => x.toJson())),
      };
}

class Organization {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Building>? buildings;

  Organization({
    this.id,
    this.name,
    this.previousName,
    this.buildings,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        buildings: json['buildings'] == null
            ? null
            : List<Building>.from(
                json['buildings'].map((x) => Building.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'buildings': buildings == null
            ? null
            : List<dynamic>.from(buildings!.map((x) => x.toJson())),
      };
}

class Building {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Floor>? floors;

  Building({
    this.id,
    this.name,
    this.previousName,
    this.floors,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        floors: json['floors'] == null
            ? null
            : List<Floor>.from(json['floors'].map((x) => Floor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'floors': floors == null
            ? null
            : List<dynamic>.from(floors!.map((x) => x.toJson())),
      };
}

class Floor {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Section>? sections;

  Floor({
    this.id,
    this.name,
    this.previousName,
    this.sections,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        sections: json['sections'] == null
            ? null
            : List<Section>.from(
                json['sections'].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'sections': sections == null
            ? null
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Section {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Point>? points;

  Section({
    this.id,
    this.name,
    this.previousName,
    this.points,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        points: json['points'] == null
            ? null
            : List<Point>.from(json['points'].map((x) => Point.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'points': points == null
            ? null
            : List<dynamic>.from(points!.map((x) => x.toJson())),
      };
}

class Point {
  final int? id;
  final String? name;
  final String? previousName;
  final Device? device;

  Point({
    this.id,
    this.name,
    this.previousName,
    this.device,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        device: json['device'] == null ? null : Device.fromJson(json['device']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'device': device?.toJson(),
      };
}

class Device {
  final int? id;
  final String? name;

  Device({
    this.id,
    this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
