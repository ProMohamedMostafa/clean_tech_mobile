class AttendanceLeavesModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  dynamic businessErrorCode;
  AttendanceLeavesData? data;

  AttendanceLeavesModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  AttendanceLeavesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? AttendanceLeavesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'businessErrorCode': businessErrorCode,
      'data': data?.toJson(),
    };
  }
}

class AttendanceLeavesData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  dynamic meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<LeaveRecord>? leaves;

  AttendanceLeavesData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.leaves,
  });

  AttendanceLeavesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      leaves = (json['data'] as List).map((v) => LeaveRecord.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalCount': totalCount,
      'meta': meta,
      'pageSize': pageSize,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
      'succeeded': succeeded,
      'data': leaves?.map((v) => v.toJson()).toList(),
    };
  }
}

class LeaveRecord {
  int? id;
  int? userId;
  String? role;
  String? userName;
  String? firstName;
  String? lastName;
  String? startDate;
  String? endDate;
  String? reason;
  String? type;
  String? file;

  LeaveRecord({
    this.id,
    this.userId,
    this.role,
    this.userName,
    this.firstName,
    this.lastName,
    this.startDate,
    this.endDate,
    this.reason,
    this.type,
    this.file,
  });

  LeaveRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    role = json['role'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    type = json['type'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'role': role,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
      'type': type,
      'file': file,
    };
  }
}
