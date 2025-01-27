class OrganizationManagersDetailsModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  Data? data;

  OrganizationManagersDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  OrganizationManagersDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  List<Manager>? managers;
  List<Supervisor>? supervisors;
  List<Cleaner>? cleaners;

  Data({
    this.managers,
    this.supervisors,
    this.cleaners,
  });

  Data.fromJson(Map<String, dynamic> json) {
    managers = (json['managers'] as List?)?.map((v) => Manager.fromJson(v)).toList();
    supervisors = (json['supervisors'] as List?)?.map((v) => Supervisor.fromJson(v)).toList();
    cleaners = (json['cleaners'] as List?)?.map((v) => Cleaner.fromJson(v)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (managers != null) {
      data['managers'] = managers!.map((v) => v.toJson()).toList();
    }
    if (supervisors != null) {
      data['supervisors'] = supervisors!.map((v) => v.toJson()).toList();
    }
    if (cleaners != null) {
      data['cleaners'] = cleaners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  Manager({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}

class Supervisor {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  Supervisor({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  Supervisor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}

class Cleaner {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  Cleaner({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.image,
  });

  Cleaner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
