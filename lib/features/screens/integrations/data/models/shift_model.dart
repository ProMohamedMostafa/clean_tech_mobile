class ShiftModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  ShiftData? data;

  ShiftModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: ShiftData.fromJson(json['data']),
    );
  }
}

class ShiftData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<ShiftItem>? data;

  ShiftData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    return ShiftData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: List<ShiftItem>.from(json['data'].map((x) => ShiftItem.fromJson(x))),
    );
  }
}

class ShiftItem {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  ShiftItem({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  factory ShiftItem.fromJson(Map<String, dynamic> json) {
    return ShiftItem(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
