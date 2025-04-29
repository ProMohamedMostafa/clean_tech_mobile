class AreaListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  AreaData? data;

  AreaListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory AreaListModel.fromJson(Map<String, dynamic> json) {
    return AreaListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: AreaData.fromJson(json['data']),
    );
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
  List<AreaItem>? data;

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

  factory AreaData.fromJson(Map<String, dynamic> json) {
    return AreaData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: List<AreaItem>.from(json['data'].map((x) => AreaItem.fromJson(x))),
    );
  }
}

class AreaItem {
  int? id;
  String? name;
  String? countryName;

  AreaItem({
    this.id,
    this.name,
    this.countryName,
  });

  factory AreaItem.fromJson(Map<String, dynamic> json) {
    return AreaItem(
      id: json['id'],
      name: json['name'],
      countryName: json['countryName'],
    );
  }
}
