class AreaDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  AreaDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  AreaDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['statusCode'] = statusCode;
    json['meta'] = meta;
    json['succeeded'] = succeeded;
    json['message'] = message;
    json['error'] = error;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  int? id;
  String? name;
  String? countryName;
  List<dynamic>? managers;
  List<dynamic>? supervisors;
  List<dynamic>? cleaners;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.countryName,
    this.managers,
    this.supervisors,
    this.cleaners,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryName = json['countryName'];
    managers = json['managers'] ?? [];
    supervisors = json['supervisors'] ?? [];
    cleaners = json['cleaners'] ?? [];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['countryName'] = countryName;
    json['managers'] = managers;
    json['supervisors'] = supervisors;
    json['cleaners'] = cleaners;
    json['createdAt'] = createdAt?.toIso8601String();
    json['updatedAt'] = updatedAt?.toIso8601String();
    return json;
  }
}
