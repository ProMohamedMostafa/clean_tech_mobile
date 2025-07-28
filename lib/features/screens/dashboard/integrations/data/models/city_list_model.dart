class CityListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  CityData? data;

  CityListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) {
    return CityListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? CityData.fromJson(json['data']) : null,
    );
  }
}

class CityData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<CityItem>? data;

  CityData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: json['data'] != null
          ? List<CityItem>.from(json['data'].map((x) => CityItem.fromJson(x)))
          : [],
    );
  }
}

class CityItem {
  int? id;
  String? name;
  int? areaId;
  String? areaName;
  String? countryName;

  CityItem({
    this.id,
    this.name,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory CityItem.fromJson(Map<String, dynamic> json) {
    return CityItem(
      id: json['id'],
      name: json['name'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}
