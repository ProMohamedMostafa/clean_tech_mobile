class LeavesDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  LeavesDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  LeavesDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? role;
  String? userName;
  String? firstName;
  String? lastName;
  String? image;
  String? startDate;
  String? endDate;
  String? reason;
  String? type;
  int? typeId;
  String? file;
  String? status;
  int? approvedById;
  String? approvedAt;
  String? rejectionReason;

  Data({
    this.id,
    this.userId,
    this.role,
    this.userName,
    this.firstName,
    this.lastName,
    this.image,
    this.startDate,
    this.endDate,
    this.reason,
    this.type,
    this.typeId,
    this.file,
    this.status,
    this.approvedById,
    this.approvedAt,
    this.rejectionReason,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    role = json['role'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    type = json['type'];
    typeId = json['typeId'];
    file = json['file'];
    status = json['status'];
    approvedById = json['approvedById'];
    approvedAt = json['approvedAt'];
    rejectionReason = json['rejectionReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['role'] = role;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['reason'] = reason;
    data['type'] = type;
    data['typeId'] = typeId;
    data['file'] = file;
    data['status'] = status;
    data['approvedById'] = approvedById;
    data['approvedAt'] = approvedAt;
    data['rejectionReason'] = rejectionReason;
    return data;
  }
}
