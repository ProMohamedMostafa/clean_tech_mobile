class TaskDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  TaskDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    data['businessErrorCode'] = businessErrorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  double? readingAfter; // Added
  String? organizationName;
  String? buildingName;
  int? buildingId; // Added
  String? floorName;
  int? floorId; // Added
  String? sectionName;
  int? sectionId; // Added
  String? pointName;
  int? pointId; // Added
  String? parentTitle;
  int? parentId; // Added
  int? createdBy;
  String? createdUserName;
  String? started;
  String? duration;
  List<Users>? users;
  List<Files>? files;
  List<Comments>? comments;

  Data(
      {this.id,
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
      this.readingAfter, // Added
      this.organizationName,
      this.buildingName,
      this.buildingId, // Added
      this.floorName,
      this.floorId, // Added
      this.sectionName,
      this.sectionId, // Added
      this.pointName,
      this.pointId, // Added
      this.parentTitle,
      this.parentId, // Added
      this.createdBy,
      this.createdUserName,
      this.started,
      this.duration,
      this.users,
      this.files,
      this.comments});

  Data.fromJson(Map<String, dynamic> json) {
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
    readingAfter = json['readingAfter']; // Added
    organizationName = json['organizationName'];
    buildingName = json['buildingName'];
    buildingId = json['buildingId']; // Added
    floorName = json['floorName'];
    floorId = json['floorId']; // Added
    sectionName = json['sectionName'];
    sectionId = json['sectionId']; // Added
    pointName = json['pointName'];
    pointId = json['pointId']; // Added
    parentTitle = json['parentTitle'];
    parentId = json['parentId']; // Added
    createdBy = json['createdBy'];
    createdUserName = json['createdUserName'];
    started = json['started'];
    duration = json['duration'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['readingAfter'] = readingAfter; // Added
    data['organizationName'] = organizationName;
    data['buildingName'] = buildingName;
    data['buildingId'] = buildingId; // Added
    data['floorName'] = floorName;
    data['floorId'] = floorId; // Added
    data['sectionName'] = sectionName;
    data['sectionId'] = sectionId; // Added
    data['pointName'] = pointName;
    data['pointId'] = pointId; // Added
    data['parentTitle'] = parentTitle;
    data['parentId'] = parentId; // Added
    data['createdBy'] = createdBy;
    data['createdUserName'] = createdUserName;
    data['started'] = started;
    data['duration'] = duration;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  Users(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.role,
      this.email,
      this.image});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Files {
  String? path;

  Files({this.path});

  Files.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    return data;
  }
}

class Comments {
  String? userName;
  String? role;
  String? comment;
  String? createdAt;
  List<Files>? files;

  Comments(
      {this.userName, this.role, this.comment, this.createdAt, this.files});

  Comments.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    role = json['role'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['role'] = role;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
