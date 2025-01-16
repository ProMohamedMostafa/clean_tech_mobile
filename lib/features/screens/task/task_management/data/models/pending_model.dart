class PendingModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  PaginatedData? data;

  PendingModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  PendingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class PaginatedData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  dynamic meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<TaskData>? items;

  PaginatedData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.items,
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
      items = [];
      json['data'].forEach((v) {
        items!.add(TaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['meta'] = meta;
    data['pageSize'] = pageSize;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    data['succeeded'] = succeeded;
    if (items != null) {
      data['data'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskData {
  int? id;
  String? title;
  String? description;
  String? priority;
  String? status;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? organizationName;
  String? buildingName;
  String? floorName;
  String? pointName;
  String? parentTitle;
  int? createdBy;
  String? createdName;

  TaskData({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.status,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.organizationName,
    this.buildingName,
    this.floorName,
    this.pointName,
    this.parentTitle,
    this.createdBy,
    this.createdName,
  });

  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    organizationName = json['organizationName'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    pointName = json['pointName'];
    parentTitle = json['parentTitle'];
    createdBy = json['createdBy'];
    createdName = json['createdName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['organizationName'] = organizationName;
    data['buildingName'] = buildingName;
    data['floorName'] = floorName;
    data['pointName'] = pointName;
    data['parentTitle'] = parentTitle;
    data['createdBy'] = createdBy;
    data['createdName'] = createdName;
    return data;
  }
}
