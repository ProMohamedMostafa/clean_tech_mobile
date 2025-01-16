class AllTasksModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  PaginatedData? data;

  AllTasksModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  AllTasksModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['meta'] = meta;
    result['succeeded'] = succeeded;
    result['message'] = message;
    result['error'] = error;
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
      data = List<TaskData>.from(
        json['data'].map((v) => TaskData.fromJson(v)),
      );
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
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['title'] = title;
    result['description'] = description;
    result['priority'] = priority;
    result['status'] = status;
    result['startDate'] = startDate;
    result['endDate'] = endDate;
    result['startTime'] = startTime;
    result['endTime'] = endTime;
    result['organizationName'] = organizationName;
    result['buildingName'] = buildingName;
    result['floorName'] = floorName;
    result['pointName'] = pointName;
    result['parentTitle'] = parentTitle;
    result['createdBy'] = createdBy;
    result['createdName'] = createdName;
    return result;
  }
}
