class OrganizationListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  OrganizationData? data;

  OrganizationListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory OrganizationListModel.fromJson(Map<String, dynamic> json) {
    return OrganizationListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: OrganizationData.fromJson(json['data']),
    );
  }
}

class OrganizationData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<OrganizationItem>? data;

  OrganizationData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) {
    return OrganizationData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: List<OrganizationItem>.from(
        json['data'].map((x) => OrganizationItem.fromJson(x)),
      ),
    );
  }
}

class OrganizationItem {
  int? id;
  String? name;
  int? cityId;
  String? cityName;
  int? areaId;
  String? areaName;
  String? countryName;

  OrganizationItem({
    this.id,
    this.name,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.countryName,
  });

  factory OrganizationItem.fromJson(Map<String, dynamic> json) {
    return OrganizationItem(
      id: json['id'],
      name: json['name'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      countryName: json['countryName'],
    );
  }
}
