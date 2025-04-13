class AllShiftsModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  String? meta;
  ShiftDataModel? data;

  AllShiftsModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.meta,
    this.data,
  });

  AllShiftsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    meta = json['meta'];
    data = json['data'] != null ? ShiftDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['succeeded'] = succeeded;
    result['message'] = message;
    result['error'] = error;
    result['businessErrorCode'] = businessErrorCode;
    result['meta'] = meta;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class ShiftDataModel {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  dynamic meta;
  List<Shift>? shifts;

  ShiftDataModel({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.meta,
    this.shifts,
  });

  ShiftDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    meta = json['meta'];
    if (json['data'] != null) {
      shifts = List<Shift>.from(json['data'].map((x) => Shift.fromJson(x)));
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
    result['meta'] = meta;
    if (shifts != null) {
      result['data'] = shifts!.map((x) => x.toJson()).toList();
    }
    return result;
  }
}

class Shift {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  Shift({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['startDate'] = startDate;
    result['endDate'] = endDate;
    result['startTime'] = startTime;
    result['endTime'] = endTime;
    return result;
  }
}
