class RoleUserModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  List<DataRoleUser>? data;

  RoleUserModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  RoleUserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = json['data']
          .map<DataRoleUser>((v) => DataRoleUser.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['statusCode'] = statusCode;
    json['meta'] = meta;
    json['succeeded'] = succeeded;
    json['message'] = message;
    json['error'] = error;
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class DataRoleUser {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  List<dynamic>? shifts;

  DataRoleUser({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.shifts,
  });

  DataRoleUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['shifts'] != null) {
      shifts = List<dynamic>.from(json['shifts']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['userName'] = userName;
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    if (shifts != null) {
      json['shifts'] = shifts;
    }
    return json;
  }
}
