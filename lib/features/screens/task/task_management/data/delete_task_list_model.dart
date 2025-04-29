class DeleteTaskListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  List<DeleteTaskData>? data;

  DeleteTaskListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory DeleteTaskListModel.fromJson(Map<String, dynamic> json) {
    return DeleteTaskListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DeleteTaskData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'businessErrorCode': businessErrorCode,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class DeleteTaskData {
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
  double? currentReading;
  double? readingAfter;
  String? organizationName;
  String? buildingName;
  String? floorName;
  String? sectionName;
  String? pointName;
  String? parentTitle;
  int? createdBy;
  String? createdUserName;
  String? started;
  String? duration;
  List<DeleteTaskUser>? users;

  DeleteTaskData({
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
    this.currentReading,
    this.readingAfter,
    this.organizationName,
    this.buildingName,
    this.floorName,
    this.sectionName,
    this.pointName,
    this.parentTitle,
    this.createdBy,
    this.createdUserName,
    this.started,
    this.duration,
    this.users,
  });

  factory DeleteTaskData.fromJson(Map<String, dynamic> json) {
    return DeleteTaskData(
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
      currentReading: (json['currentReading'] as num?)?.toDouble(),
      readingAfter: (json['readingAfter'] as num?)?.toDouble(),
      organizationName: json['organizationName'],
      buildingName: json['buildingName'],
      floorName: json['floorName'],
      sectionName: json['sectionName'],
      pointName: json['pointName'],
      parentTitle: json['parentTitle'],
      createdBy: json['createdBy'],
      createdUserName: json['createdUserName'],
      started: json['started'],
      duration: json['duration'],
      users: (json['users'] as List<dynamic>?)
          ?.map((item) => DeleteTaskUser.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'currentReading': currentReading,
      'readingAfter': readingAfter,
      'organizationName': organizationName,
      'buildingName': buildingName,
      'floorName': floorName,
      'sectionName': sectionName,
      'pointName': pointName,
      'parentTitle': parentTitle,
      'createdBy': createdBy,
      'createdUserName': createdUserName,
      'started': started,
      'duration': duration,
      'users': users?.map((user) => user.toJson()).toList(),
    };
  }
}

class DeleteTaskUser {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  DeleteTaskUser({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  factory DeleteTaskUser.fromJson(Map<String, dynamic> json) {
    return DeleteTaskUser(
      id: json['id'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'email': email,
      'image': image,
    };
  }
}
