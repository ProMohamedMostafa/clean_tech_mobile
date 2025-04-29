class BuildingListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  BuildingData? data;

  BuildingListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory BuildingListModel.fromJson(Map<String, dynamic> json) {
    return BuildingListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: BuildingData.fromJson(json['data']),
    );
  }
}

class BuildingData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<BuildingItem>? data;

  BuildingData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: List<BuildingItem>.from(
          json['data'].map((x) => BuildingItem.fromJson(x))),
    );
  }
}

class BuildingItem {
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

  BuildingItem({
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
  });

  factory BuildingItem.fromJson(Map<String, dynamic> json) {
    return BuildingItem(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}
