class ActivitiesModel {
  int statusCode;
  dynamic meta;
  bool succeeded;
  String message;
  dynamic error;
  dynamic businessErrorCode;
  PaginatedActivityData data;

  ActivitiesModel({
    required this.statusCode,
    this.meta,
    required this.succeeded,
    required this.message,
    this.error,
    this.businessErrorCode,
    required this.data,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      statusCode: json['statusCode'] as int,
      meta: json['meta'],
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data:
          PaginatedActivityData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class PaginatedActivityData {
  int currentPage;
  int totalPages;
  int totalCount;
  dynamic meta;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;
  bool succeeded;
  List<Activity> data;

  PaginatedActivityData({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.meta,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.succeeded,
    required this.data,
  });

  factory PaginatedActivityData.fromJson(Map<String, dynamic> json) {
    return PaginatedActivityData(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      totalCount: json['totalCount'] as int,
      meta: json['meta'],
      pageSize: json['pageSize'] as int,
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List)
          .map((activityJson) => Activity.fromJson(activityJson))
          .toList(),
    );
  }
}

class Activity {
  String message;
  String module;
  int? moduleId;
  int? actionTypeId;
  String actionType;
  String userName;
  int userId;
  String role;
  DateTime createdAt;

  Activity({
    required this.message,
    required this.module,
    this.moduleId,
    this.actionTypeId,
    required this.actionType,
    required this.userName,
    required this.userId,
    required this.role,
    required this.createdAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      message: json['message'] as String,
      module: json['module'] as String,
      moduleId: json['moduleId'] as int?,
      actionTypeId: json['actionTypeId'] as int?,
      actionType: json['actionType'] as String,
      userName: json['userName'] as String,
      userId: json['userId'] as int,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Helper method to get a simplified action description
  String get actionDescription {
    switch (actionType) {
      case 'Login':
        return 'logged in';
      case 'ClockIn':
        return 'clocked in';
      case 'ClockOut':
        return 'clocked out';
      case 'ChangeStatus':
        return 'changed task status';
      case 'Edit':
        return 'edited a task';
      case 'Comment':
        return 'added a comment';
      default:
        return actionType;
    }
  }
}
