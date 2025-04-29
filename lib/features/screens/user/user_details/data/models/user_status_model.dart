class UserStatusModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  UserStatusModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  UserStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? clockIn;
  String? clockOut;
  String? duration;
  String? date;
  String? status;

  Data({this.clockIn, this.clockOut, this.duration, this.date, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    duration = json['duration'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clockIn'] = clockIn;
    data['clockOut'] = clockOut;
    data['duration'] = duration;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
