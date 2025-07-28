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

  AllTasksModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['meta'] = meta;
    result['succeeded'] = succeeded;
    result['message'] = message;
    result['error'] = error;
    result['businessErrorCode'] = businessErrorCode;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
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

  PaginatedData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = List<TaskData>.from(json['data'].map((v) => TaskData.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['currentPage'] = currentPage;
    result['totalPages'] = totalPages;
    result['totalCount'] = totalCount;
    result['meta'] = meta;
    result['pageSize'] = pageSize;
    result['hasPreviousPage'] = hasPreviousPage;
    result['hasNextPage'] = hasNextPage;
    result['succeeded'] = succeeded;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
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
  double? currentReading;
  String? readingAfter;
  String? organizationName;
  String? buildingName;
  String? floorName;
  String? sectionName;
  String? pointName;
  String? parentTitle;
  int? createdBy;
  String? createdUserName;
  String? deviceName;
  String? duration;
  String? started;
  List<UserModel>? users;

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
    this.deviceName,
    this.duration,
    this.started,
    this.users,
  });

  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    priorityId = json['priorityId'];
    status = json['status'];
    statusId = json['statusId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    currentReading = json['currentReading'];
    readingAfter = json['readingAfter'];
    organizationName = json['organizationName'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    sectionName = json['sectionName'];
    pointName = json['pointName'];
    parentTitle = json['parentTitle'];
    createdBy = json['createdBy'];
    createdUserName = json['createdUserName'];
    deviceName = json['deviceName'];
    duration = json['duration'];
    started = json['started'];
    if (json['users'] != null) {
      users =
          List<UserModel>.from(json['users'].map((v) => UserModel.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['title'] = title;
    result['description'] = description;
    result['priority'] = priority;
    result['priorityId'] = priorityId;
    result['status'] = status;
    result['statusId'] = statusId;
    result['startDate'] = startDate;
    result['endDate'] = endDate;
    result['startTime'] = startTime;
    result['endTime'] = endTime;
    result['currentReading'] = currentReading;
    result['readingAfter'] = readingAfter;
    result['organizationName'] = organizationName;
    result['buildingName'] = buildingName;
    result['floorName'] = floorName;
    result['sectionName'] = sectionName;
    result['pointName'] = pointName;
    result['parentTitle'] = parentTitle;
    result['createdBy'] = createdBy;
    result['createdUserName'] = createdUserName;
    result['deviceName'] = deviceName;
    result['duration'] = duration;
    result['started'] = started;
    if (users != null) {
      result['users'] = users!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class UserModel {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  UserModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['userName'] = userName;
    result['firstName'] = firstName;
    result['lastName'] = lastName;
    result['role'] = role;
    result['email'] = email;
    result['image'] = image;
    return result;
  }
}
