class PointDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  PointDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  PointDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['meta'] = meta;
    result['succeeded'] = succeeded;
    result['message'] = message;
    result['error'] = error;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class Data {
  int? id;
  String? name;
  String? number;
  String? description;
  String? floorId;
  String? floorName;
  String? buildingId;
  String? buildingName;
  String? organizationId;
  String? organizationName;
  String? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;
  List<dynamic>? managers;
  List<dynamic>? supervisors;
  List<dynamic>? cleaners;
  List<dynamic>? shifts;
  String? createdAt;
  String? updatedAt;

  Data({
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
    this.managers,
    this.supervisors,
    this.cleaners,
    this.shifts,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    description = json['description'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
    managers = json['managers'] ?? [];
    supervisors = json['supervisors'] ?? [];
    cleaners = json['cleaners'] ?? [];
    shifts = json['shifts'] ?? [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['number'] = number;
    result['description'] = description;
    result['floorId'] = floorId;
    result['floorName'] = floorName;
    result['buildingId'] = buildingId;
    result['buildingName'] = buildingName;
    result['organizationId'] = organizationId;
    result['organizationName'] = organizationName;
    result['cityId'] = cityId;
    result['cityName'] = cityName;
    result['areaId'] = areaId;
    result['areaName'] = areaName;
    result['countryName'] = countryName;
    result['managers'] = managers;
    result['supervisors'] = supervisors;
    result['cleaners'] = cleaners;
    result['shifts'] = shifts;
    result['createdAt'] = createdAt;
    result['updatedAt'] = updatedAt;
    return result;
  }
}
