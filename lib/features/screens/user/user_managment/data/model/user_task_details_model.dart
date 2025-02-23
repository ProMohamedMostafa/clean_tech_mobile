class UserTaskDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  UserTaskDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  UserTaskDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Task>? data;

  Data(
      {this.currentPage,
      this.totalPages,
      this.totalCount,
      this.meta,
      this.pageSize,
      this.hasPreviousPage,
      this.hasNextPage,
      this.succeeded,
      this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = <Task>[];
      json['data'].forEach((v) {
        data!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['meta'] = meta;
    data['pageSize'] = pageSize;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    data['succeeded'] = succeeded;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  int? id;
  String? title;
  String? description;
  String? priority;
  String? status;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? organizationId;
  String? organizationName;
  int? buildingId;
  String? buildingName;
  int? floorId;
  String? floorName;
  int? pointId;
  String? pointName;
  int? parentId;
  String? parentTitle;
  int? createdBy;
  String? createdName;

  Task(
      {this.id,
      this.title,
      this.description,
      this.priority,
      this.status,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.organizationId,
      this.organizationName,
      this.buildingId,
      this.buildingName,
      this.floorId,
      this.floorName,
      this.pointId,
      this.pointName,
      this.parentId,
      this.parentTitle,
      this.createdBy,
      this.createdName});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    pointId = json['pointId'];
    pointName = json['pointName'];
    parentId = json['parentId'];
    parentTitle = json['parentTitle'];
    createdBy = json['createdBy'];
    createdName = json['createdName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['organizationId'] = organizationId;
    data['organizationName'] = organizationName;
    data['buildingId'] = buildingId;
    data['buildingName'] = buildingName;
    data['floorId'] = floorId;
    data['floorName'] = floorName;
    data['pointId'] = pointId;
    data['pointName'] = pointName;
    data['parentId'] = parentId;
    data['parentTitle'] = parentTitle;
    data['createdBy'] = createdBy;
    data['createdName'] = createdName;
    return data;
  }
}
