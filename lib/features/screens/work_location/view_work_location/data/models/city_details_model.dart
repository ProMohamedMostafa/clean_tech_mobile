class CityDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  CityDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  CityDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? areaId;
  String? areaName;
  String? countryName;
  List<dynamic>? managers;
  List<dynamic>? supervisors;
  List<dynamic>? cleaners;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.areaId,
    this.areaName,
    this.countryName,
    this.managers,
    this.supervisors,
    this.cleaners,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
    managers = json['managers'];
    supervisors = json['supervisors'];
    cleaners = json['cleaners'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['countryName'] = countryName;
    data['managers'] = managers;
    data['supervisors'] = supervisors;
    data['cleaners'] = cleaners;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
