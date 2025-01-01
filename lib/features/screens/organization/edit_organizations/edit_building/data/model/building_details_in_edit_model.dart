class BuildingDetailsInEditModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  BuildingData? data;

  BuildingDetailsInEditModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  BuildingDetailsInEditModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? BuildingData.fromJson(json['data']) : null;
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

class BuildingData {
  int? id;
  String? name;
  String? number;
  String? description;
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

  BuildingData({
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
    this.managers,
    this.supervisors,
    this.cleaners,
    this.shifts,
    this.createdAt,
    this.updatedAt,
  });

  BuildingData.fromJson(Map<String, dynamic> json) {
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
    managers = json['managers'] != null ? List<dynamic>.from(json['managers']) : null;
    supervisors = json['supervisors'] != null ? List<dynamic>.from(json['supervisors']) : null;
    cleaners = json['cleaners'] != null ? List<dynamic>.from(json['cleaners']) : null;
    shifts = json['shifts'] != null ? List<dynamic>.from(json['shifts']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    if (managers != null) {
      data['managers'] = managers;
    }
    if (supervisors != null) {
      data['supervisors'] = supervisors;
    }
    if (cleaners != null) {
      data['cleaners'] = cleaners;
    }
    if (shifts != null) {
      data['shifts'] = shifts;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
