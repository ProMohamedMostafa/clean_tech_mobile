class DeletedSensorListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  List<Data>? data;

  DeletedSensorListModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  DeletedSensorListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? applicationName;
  String? pointName;
  int? battery;
  bool? active;

  Data(
      {this.id,
      this.name,
      this.applicationName,
      this.pointName,
      this.battery,
      this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    applicationName = json['applicationName'];
    pointName = json['pointName'];
    battery = json['battery'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['applicationName'] = applicationName;
    data['pointName'] = pointName;
    data['battery'] = battery;
    data['active'] = active;
    return data;
  }
}
