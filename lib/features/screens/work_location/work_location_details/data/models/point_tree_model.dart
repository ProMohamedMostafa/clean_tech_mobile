class PointTreeModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  PointTreeModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  PointTreeModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? previousName;
  List<Device>? devices;

  Data({this.id, this.name, this.previousName, this.devices});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previousName = json['previousName'];
    if (json['devices'] != null) {
      devices = <Device>[];
      json['devices'].forEach((v) {
        devices!.add(Device.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['previousName'] = previousName;
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Device {
  final int? id;
  final String? name;

  Device({
    this.id,
    this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
