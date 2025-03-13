class UserWorkLocationDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  dynamic businessErrorCode;
  Data? data;

  UserWorkLocationDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  UserWorkLocationDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['statusCode'] = statusCode;
    json['meta'] = meta;
    json['succeeded'] = succeeded;
    json['message'] = message;
    json['error'] = error;
    json['businessErrorCode'] = businessErrorCode;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  List<dynamic>? areas;
  List<dynamic>? cities;
  List<dynamic>? organizations;
  List<dynamic>? buildings;
  List<dynamic>? floors;
  List<dynamic>? sections;
  List<dynamic>? points;

  Data({
    this.areas,
    this.cities,
    this.organizations,
    this.buildings,
    this.floors,
    this.sections,
    this.points,
  });

  Data.fromJson(Map<String, dynamic> json) {
    areas = json['areas'] ?? [];
    cities = json['cities'] ?? [];
    organizations = json['organizations'] ?? [];
    buildings = json['buildings'] ?? [];
    floors = json['floors'] ?? [];
    sections = json['sections'] ?? [];
    points = json['points'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['areas'] = areas;
    json['cities'] = cities;
    json['organizations'] = organizations;
    json['buildings'] = buildings;
    json['floors'] = floors;
    json['sections'] = sections;
    json['points'] = points;
    return json;
  }
}
