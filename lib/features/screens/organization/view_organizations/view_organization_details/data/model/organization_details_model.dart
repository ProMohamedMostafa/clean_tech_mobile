class OrganizationDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  OrganizationDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  OrganizationDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'meta': meta,
        'succeeded': succeeded,
        'message': message,
        'error': error,
        'data': data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
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
    cityId = json['cityId'];
    cityName = json['cityName'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
    managers = json['managers'];
    supervisors = json['supervisors'];
    cleaners = json['cleaners'];
    shifts = json['shifts'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cityId': cityId,
        'cityName': cityName,
        'areaId': areaId,
        'areaName': areaName,
        'countryName': countryName,
        'managers': managers,
        'supervisors': supervisors,
        'cleaners': cleaners,
        'shifts': shifts,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
