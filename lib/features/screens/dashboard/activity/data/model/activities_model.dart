class ActivitiesModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  ActivitiesData? data;

  ActivitiesModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? ActivitiesData.fromJson(json['data']) : null,
    );
  }
}

class ActivitiesData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Activity>? activities;

  ActivitiesData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.activities,
  });

  factory ActivitiesData.fromJson(Map<String, dynamic> json) {
    return ActivitiesData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      activities: json['data'] != null
          ? List<Activity>.from(json['data'].map((x) => Activity.fromJson(x)))
          : [],
    );
  }
}

class Activity {
  String? message;
  String? module;
  int? moduleId;
  String? actionType;
  int? actionTypeId;
  String? userName;
  int? userId;
  String? role;
  DateTime? createdAt;

  Activity({
    this.message,
    this.module,
    this.moduleId,
    this.actionType,
    this.actionTypeId,
    this.userName,
    this.userId,
    this.role,
    this.createdAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      message: json['message'],
      module: json['module'],
      moduleId: json['moduleId'],
      actionType: json['actionType'],
      actionTypeId: json['actionTypeId'],
      userName: json['userName'],
      userId: json['userId'],
      role: json['role'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
