class ShiftBuildingsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  List<Data>? data;

  ShiftBuildingsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  ShiftBuildingsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? organizationName;

  Data({this.id, this.name, this.organizationName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizationName = json['organizationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['organizationName'] = organizationName;
    return data;
  }
}
