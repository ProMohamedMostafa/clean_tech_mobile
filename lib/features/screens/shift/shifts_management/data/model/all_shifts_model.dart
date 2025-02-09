class AllShiftsModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  Data? data;

  AllShiftsModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.data,
  });

  AllShiftsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Shift>? shifts;

  Data({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.shifts,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      shifts = List<Shift>.from(json['data'].map((v) => Shift.fromJson(v)));
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
    if (shifts != null) {
      result['data'] = shifts!.map((v) => v.toJson()).toList();
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
