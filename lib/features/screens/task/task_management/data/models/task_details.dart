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
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  String? status;
  int? statusId;
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

  Data(
      {this.id,
      this.title,
      this.description,
      this.priority,
      this.status,
      this.statusId,
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    status = json['status'];
    statusId = json['statusId'];
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['status'] = status;
    data['statusId'] = statusId;
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
