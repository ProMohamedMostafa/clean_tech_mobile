class NotificationModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  NotificationData? data;

  NotificationModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: NotificationData.fromJson(json['data']),
    );
  }
}

class NotificationData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<NotificationItem>? data;

  NotificationData({
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

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NotificationItem> items =
        list.map((i) => NotificationItem.fromJson(i)).toList();

    return NotificationData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: items,
    );
  }
}

class NotificationItem {
  String? message;
  String? module;
  int? moduleId;
  String? actionType;
  int? actionTypeId;
  String? userName;
  int? userId;
  String? image;
  String? role;
  bool? isRead;
  DateTime? createdAt;

  NotificationItem({
    this.message,
    this.module,
    this.moduleId,
    this.actionType,
    this.actionTypeId,
    this.userName,
    this.userId,
    this.image,
    this.role,
    this.isRead,
    this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      message: json['message'],
      module: json['module'],
      moduleId: json['moduleId'],
      actionType: json['actionType'],
      actionTypeId: json['actionTypeId'],
      userName: json['userName'],
      userId: json['userId'],
      image: json['image'],
      role: json['role'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
