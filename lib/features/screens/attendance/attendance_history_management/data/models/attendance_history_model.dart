class AttendanceHistoryModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  AttendanceDataModel? data;

  AttendanceHistoryModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null
          ? AttendanceDataModel.fromJson(json['data'])
          : null,
    );
  }
}

class AttendanceDataModel {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<AttendanceRecord>? data;

  AttendanceDataModel({
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

  factory AttendanceDataModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDataModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttendanceRecord.fromJson(e))
          .toList(),
    );
  }
}

class AttendanceRecord {
  int? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? role;
  String? startShift;
  String? endShift;
  String? clockIn;
  String? clockOut;
  String? duration;
  String? date;
  String? status;

  AttendanceRecord({
    this.userId,
    this.firstName,
    this.lastName,
    this.userName,
    this.role,
    this.startShift,
    this.endShift,
    this.clockIn,
    this.clockOut,
    this.duration,
    this.date,
    this.status,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      role: json['role'],
      startShift: json['startShift'],
      endShift: json['endShift'],
      clockIn: json['clockIn'],
      clockOut: json['clockOut'],
      duration: json['duration'],
      date: json['date'],
      status: json['status'],
    );
  }
}
