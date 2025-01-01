class FloorDetailsInEditModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  FloorDetailsInEditModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  FloorDetailsInEditModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? number;
  String? description;
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['description'] = description;
    data['buildingId'] = buildingId;
    data['buildingName'] = buildingName;
    data['organizationId'] = organizationId;
    data['organizationName'] = organizationName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['countryName'] = countryName;
    data['managers'] = managers;
    data['supervisors'] = supervisors;
    data['cleaners'] = cleaners;
    data['shifts'] = shifts;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
