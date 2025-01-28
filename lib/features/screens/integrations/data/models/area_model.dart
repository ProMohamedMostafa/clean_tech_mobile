class AreaModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  AreaData? data;

  AreaModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.data,
  });

  AreaModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    data = json['data'] != null ? AreaData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['succeeded'] = succeeded;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class AreaData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Area>? data;

  AreaData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  AreaData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = List<Area>.from(json['data'].map((v) => Area.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['currentPage'] = currentPage;
    result['totalPages'] = totalPages;
    result['totalCount'] = totalCount;
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
