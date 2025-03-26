class AllTasksModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  PaginatedData? data;

  AllTasksModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory AllTasksModel.fromJson(Map<String, dynamic> json) => AllTasksModel(
        statusCode: json['statusCode'],
        meta: json['meta'],
        succeeded: json['succeeded'],
        message: json['message'],
        error: json['error'],
        businessErrorCode: json['businessErrorCode'],
        data:
            json['data'] != null ? PaginatedData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'meta': meta,
        'succeeded': succeeded,
        'message': message,
        'error': error,
        'businessErrorCode': businessErrorCode,
        'data': data?.toJson(),
      };
}

class PaginatedData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<TaskData>? data;

  PaginatedData({
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

  factory PaginatedData.fromJson(Map<String, dynamic> json) => PaginatedData(
        currentPage: json['currentPage'],
        totalPages: json['totalPages'],
        totalCount: json['totalCount'],
        meta: json['meta'],
        pageSize: json['pageSize'],
        hasPreviousPage: json['hasPreviousPage'],
        hasNextPage: json['hasNextPage'],
        succeeded: json['succeeded'],
        data: json['data'] != null
            ? List<TaskData>.from(json['data'].map((v) => TaskData.fromJson(v)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'totalPages': totalPages,
        'totalCount': totalCount,
        'meta': meta,
        'pageSize': pageSize,
        'hasPreviousPage': hasPreviousPage,
        'hasNextPage': hasNextPage,
        'succeeded': succeeded,
        'data': data?.map((v) => v.toJson()).toList(),
      };
}

class TaskData {
  int? id;
  String? title;
  String? description;
  String? priority;
  int? priorityId;
  String? status;
  int? statusId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? organizationName;
  String? buildingName;
  String? floorName;
  String? sectionName;
  String? pointName;
  String? parentTitle;
  int? createdBy;
  String? createdUserName;
  List<UserData>? users;

  TaskData({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.priorityId,
    this.status,
    this.statusId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.organizationName,
    this.buildingName,
    this.floorName,
    this.sectionName,
    this.pointName,
    this.parentTitle,
    this.createdBy,
    this.createdUserName,
    this.users,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) => TaskData(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        priority: json['priority'],
        priorityId: json['priorityId'],
        status: json['status'],
        statusId: json['statusId'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        organizationName: json['organizationName'],
        buildingName: json['buildingName'],
        floorName: json['floorName'],
        sectionName: json['sectionName'],
        pointName: json['pointName'],
        parentTitle: json['parentTitle'],
        createdBy: json['createdBy'],
        createdUserName: json['createdUserName'],
        users: json['users'] != null
            ? List<UserData>.from(
                json['users'].map((v) => UserData.fromJson(v)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'priorityId': priorityId,
        'status': status,
        'statusId': statusId,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'organizationName': organizationName,
        'buildingName': buildingName,
        'floorName': floorName,
        'sectionName': sectionName,
        'pointName': pointName,
        'parentTitle': parentTitle,
        'createdBy': createdBy,
        'createdUserName': createdUserName,
        'users': users?.map((v) => v.toJson()).toList(),
      };
}

class UserData {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  UserData({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        userName: json['userName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        role: json['role'],
        email: json['email'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'email': email,
        'image': image,
      };
}
