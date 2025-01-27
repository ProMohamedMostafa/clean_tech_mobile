class AllCleanersModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  List<CleanersData>? data;

  AllCleanersModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  AllCleanersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CleanersData>[];
      json['data'].forEach((v) {
        data!.add( CleanersData.fromJson(v));
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

class CleanersData {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;

  CleanersData(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.role,
      this.email,
      this.image});

  CleanersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
