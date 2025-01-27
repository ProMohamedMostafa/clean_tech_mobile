class OrganizationListModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  OrganizationData? data;

  OrganizationListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  OrganizationListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? OrganizationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['meta'] = meta;
    result['succeeded'] = succeeded;
    result['message'] = message;
    result['error'] = error;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class OrganizationData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  dynamic meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<OrganizationItem>? data;

  OrganizationData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  OrganizationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = List<OrganizationItem>.from(
        json['data'].map((v) => OrganizationItem.fromJson(v)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['currentPage'] = currentPage;
    result['totalPages'] = totalPages;
    result['totalCount'] = totalCount;
    result['meta'] = meta;
    result['pageSize'] = pageSize;
    result['hasPreviousPage'] = hasPreviousPage;
    result['hasNextPage'] = hasNextPage;
    result['succeeded'] = succeeded;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
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

  OrganizationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['cityId'] = cityId;
    result['cityName'] = cityName;
    result['areaId'] = areaId;
    result['areaName'] = areaName;
    result['countryName'] = countryName;
    return result;
  }
}
