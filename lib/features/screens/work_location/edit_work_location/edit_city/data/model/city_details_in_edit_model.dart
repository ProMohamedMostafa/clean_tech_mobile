class CityDetailsInEditModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  CityDetailsInEditModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  CityDetailsInEditModel.fromJson(Map<String, dynamic> json) {
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
  int? areaId;
  String? areaName;
  String? countryName;
  List<Manager>? managers;
  List<Supervisor>? supervisors;
  List<Cleaner>? cleaners;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.areaId,
    this.areaName,
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
    areaId = json['areaId'];
    areaName = json['areaName'];
    countryName = json['countryName'];
    if (json['managers'] != null) {
      managers = (json['managers'] as List)
          .map((manager) => Manager.fromJson(manager))
          .toList();
    }
    if (json['supervisors'] != null) {
      supervisors = (json['supervisors'] as List)
          .map((supervisor) => Supervisor.fromJson(supervisor))
          .toList();
    }
    if (json['cleaners'] != null) {
      cleaners = (json['cleaners'] as List)
          .map((cleaner) => Cleaner.fromJson(cleaner))
          .toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['areaId'] = areaId;
    json['areaName'] = areaName;
    json['countryName'] = countryName;
    if (managers != null) {
      json['managers'] = managers!.map((manager) => manager.toJson()).toList();
    }
    if (supervisors != null) {
      json['supervisors'] =
          supervisors!.map((supervisor) => supervisor.toJson()).toList();
    }
    if (cleaners != null) {
      json['cleaners'] = cleaners!.map((cleaner) => cleaner.toJson()).toList();
    }
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}

class Manager {
  int? id;
  String? name;

  Manager({this.id, this.name});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    return json;
  }
}

class Supervisor {
  int? id;
  String? name;

  Supervisor({this.id, this.name});

  Supervisor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    return json;
  }
}

class Cleaner {
  int? id;
  String? name;

  Cleaner({this.id, this.name});

  Cleaner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    return json;
  }
}
