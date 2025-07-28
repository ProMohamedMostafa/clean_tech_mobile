class PointListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  PointData? data;

  PointListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory PointListModel.fromJson(Map<String, dynamic> json) {
    return PointListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? PointData.fromJson(json['data']) : null,
    );
  }
}

class PointData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  String? meta;
  List<PointItem>? data;

  PointData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.meta,
    this.data,
  });

  factory PointData.fromJson(Map<String, dynamic> json) {
    return PointData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      meta: json['meta'],
      data: json['data'] != null
          ? List<PointItem>.from(json['data'].map((x) => PointItem.fromJson(x)))
          : [],
    );
  }
}

class PointItem {
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
  String? deviceName;
  int? deviceId;
  bool? hasDevice;

  PointItem({
    this.id,
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
    this.countryName,
    this.deviceName,
    this.deviceId,
    this.hasDevice,
  });

  factory PointItem.fromJson(Map<String, dynamic> json) {
    return PointItem(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      isCountable: json['isCountable'],
      capacity: json['capacity'],
      unit: json['unit'],
      sectionId: json['sectionId'],
      sectionName: json['sectionName'],
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
      deviceName: json['deviceName'],
      deviceId: json['deviceId'],
      hasDevice: json['hasDevice'],
    );
  }
}
