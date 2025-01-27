class AreaListModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  AreaListData? data;

  AreaListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  AreaListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? AreaListData.fromJson(json['data']) : null;
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

class AreaListData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  dynamic meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Area>? areas;

  AreaListData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.areas,
  });

  AreaListData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      areas = (json['data'] as List).map((v) => Area.fromJson(v)).toList();
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
    if (areas != null) {
      result['data'] = areas!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class Area {
  int? id;
  String? name;
  String? countryName;

  Area({
    this.id,
    this.name,
    this.countryName,
  });

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['countryName'] = countryName;
    return result;
  }
}
