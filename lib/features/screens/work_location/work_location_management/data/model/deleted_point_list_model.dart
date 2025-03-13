class DeletedPointList {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  List<Data>? data;

  DeletedPointList(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  DeletedPointList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    data['businessErrorCode'] = businessErrorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? number;
  String? description;
  bool? isCountable;
  double? capacity;
  String? unit;
  int? sectionId;
  String? sectionName;
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

  Data(
      {this.id,
      this.name,
      this.number,
      this.description,
      this.isCountable,
      this.capacity,
      this.unit,
      this.sectionId,
      this.sectionName,
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
      this.countryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    description = json['description'];
    isCountable = json['isCountable'];
    capacity = json['capacity'];
    unit = json['unit'];
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['description'] = description;
    data['isCountable'] = isCountable;
    data['capacity'] = capacity;
    data['unit'] = unit;
    data['sectionId'] = sectionId;
    data['sectionName'] = sectionName;
    data['floorId'] = floorId;
    data['floorName'] = floorName;
    data['buildingId'] = buildingId;
    data['buildingName'] = buildingName;
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
