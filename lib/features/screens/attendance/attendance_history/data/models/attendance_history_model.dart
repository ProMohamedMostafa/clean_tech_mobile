class AttendanceHistoryModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  AttendanceHistoryModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['statusCode'] = statusCode;
    map['meta'] = meta;
    map['succeeded'] = succeeded;
    map['message'] = message;
    map['error'] = error;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  dynamic meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<UserData>? data;

  Data({
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

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = (json['data'] as List).map((v) => UserData.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    map['totalCount'] = totalCount;
    map['meta'] = meta;
    map['pageSize'] = pageSize;
    map['hasPreviousPage'] = hasPreviousPage;
    map['hasNextPage'] = hasNextPage;
    map['succeeded'] = succeeded;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class UserData {
  int? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? role;
  String? shiftStart;
  String? shiftEnd;
  String? date;
  String? clockIn;
  String? clockOut;
  String? duration;
  String? status;

  UserData({
    this.userId,
    this.firstName,
    this.lastName,
    this.userName,
    this.role,
    this.shiftStart,
    this.shiftEnd,
    this.date,
    this.clockIn,
    this.clockOut,
    this.duration,
    this.status,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    role = json['role'];
    shiftStart = json['shiftStart'];
    shiftEnd = json['shiftEnd'];
    date = json['date'];
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    duration = json['duration'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['userName'] = userName;
    map['role'] = role;
    map['shiftStart'] = shiftStart;
    map['shiftEnd'] = shiftEnd;
    map['date'] = date;
    map['clockIn'] = clockIn;
    map['clockOut'] = clockOut;
    map['duration'] = duration;
    map['status'] = status;
    return map;
  }
}
