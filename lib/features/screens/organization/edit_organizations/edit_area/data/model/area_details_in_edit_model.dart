class AreaDetailsInEditModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  AreaDetailsInEditModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  AreaDetailsInEditModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'data': data?.toJson(),
    };
  }
}

class Data {
  int? id;
  String? name;
  String? countryName;
  List<Manager>? managers;
  List<Supervisor>? supervisors;
  List<Cleaner>? cleaners;
  String? createdAt;
  String? updatedAt;

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
    if (json['managers'] != null) {
      managers =
          (json['managers'] as List).map((v) => Manager.fromJson(v)).toList();
    }
    if (json['supervisors'] != null) {
      supervisors = (json['supervisors'] as List)
          .map((v) => Supervisor.fromJson(v))
          .toList();
    }
    if (json['cleaners'] != null) {
      cleaners =
          (json['cleaners'] as List).map((v) => Cleaner.fromJson(v)).toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryName': countryName,
      'managers': managers?.map((v) => v.toJson()).toList(),
      'supervisors': supervisors?.map((v) => v.toJson()).toList(),
      'cleaners': cleaners?.map((v) => v.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Manager {
  String? name;
  String? position;

  Manager({this.name, this.position});

  Manager.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
    };
  }
}

class Supervisor {
  String? name;
  String? department;

  Supervisor({this.name, this.department});

  Supervisor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'department': department,
    };
  }
}

class Cleaner {
  String? name;
  String? shift;

  Cleaner({this.name, this.shift});

  Cleaner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shift = json['shift'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'shift': shift,
    };
  }
}
