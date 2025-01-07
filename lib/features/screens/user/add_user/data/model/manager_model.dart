class ManagerModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  List<Data>? data;

  ManagerModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  ManagerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = json['data'].map<Data>((v) => Data.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
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

class Data {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  List<Shift>? shifts;

  Data({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.shifts,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['shifts'] != null) {
      shifts = json['shifts'].map<Shift>((v) => Shift.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['userName'] = userName;
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    if (shifts != null) {
      json['shifts'] = shifts!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class Shift {
  String? startTime;
  String? endTime;

  Shift({this.startTime, this.endTime});

  Shift.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['startTime'] = startTime;
    json['endTime'] = endTime;
    return json;
  }
}
