class BuildingDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  BuildingDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  BuildingDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? number;
  String? description;
  int? organizationId;
  String? organizationName;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  Data(
      {this.id,
      this.name,
      this.number,
      this.description,
      this.organizationId,
      this.organizationName,
      this.cityId,
      this.cityName,
      this.areaId,
      this.areaName,
      this.countryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    description = json['description'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['description'] = description;
    data['organizationId'] = organizationId;
    data['organizationName'] = organizationName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['countryName'] = countryName;
    return data;
  }
}
