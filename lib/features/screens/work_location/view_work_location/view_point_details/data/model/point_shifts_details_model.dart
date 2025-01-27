class PointShiftsDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  PointShiftsDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  PointShiftsDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  List<Shifts>? shifts;

  Data({this.shifts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shifts'] != null) {
      shifts = <Shifts>[];
      json['shifts'].forEach((v) {
        shifts!.add( Shifts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (shifts != null) {
      data['shifts'] = shifts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shifts {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  Shifts(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime});

  Shifts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] =startTime;
    data['endTime'] = endTime;
    return data;
  }
}
