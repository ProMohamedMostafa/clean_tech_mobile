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
  double? readingAfter;
  String? organizationName;
  String? buildingName;
  String? floorName;
  String? sectionName;
  String? pointName;
  String? parentTitle;
  int? createdBy;
  String? createdUserName;
  String? role;
  String? deviceName;
  String? started;
  String? duration;
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
    this.role,
    this.deviceName,
    this.started,
    this.duration,
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
    currentReading = (json['currentReading'] as num?)?.toDouble();
    readingAfter = (json['readingAfter'] as num?)?.toDouble();
    organizationName = json['organizationName'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    sectionName = json['sectionName'];
    pointName = json['pointName'];
    parentTitle = json['parentTitle'];
    createdBy = json['createdBy'];
    createdUserName = json['createdUserName'];
    role = json['role'];
    deviceName = json['deviceName'];
    started = json['started'];
    duration = json['duration'];
    if (json['users'] != null) {
      users = List<UserModel>.from(
        json['users'].map((x) => UserModel.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['priorityId'] = priorityId;
    data['status'] = status;
    data['statusId'] = statusId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['currentReading'] = currentReading;
    data['readingAfter'] = readingAfter;
    data['organizationName'] = organizationName;
    data['buildingName'] = buildingName;
    data['floorName'] = floorName;
    data['sectionName'] = sectionName;
    data['pointName'] = pointName;
    data['parentTitle'] = parentTitle;
    data['createdBy'] = createdBy;
    data['createdUserName'] = createdUserName;
    data['role'] = role;
    data['deviceName'] = deviceName;
    data['started'] = started;
    data['duration'] = duration;
    if (users != null) {
      data['users'] = users!.map((x) => x.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
