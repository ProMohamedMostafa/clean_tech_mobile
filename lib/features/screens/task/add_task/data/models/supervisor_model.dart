class SupervisorModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  List<SupervisorData>? data;

  SupervisorModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  SupervisorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SupervisorData>[];
      json['data'].forEach((v) {
        data!.add(SupervisorData.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupervisorData {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? image;
  String? gender;
  String? countryName;
  String? nationalityName;
  String? email;
  String? phoneNumber;
  String? birthdate;
  String? idNumber;
  String? providerName;
  String? managerName;
  String? role;

  SupervisorData(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.image,
      this.gender,
      this.countryName,
      this.nationalityName,
      this.email,
      this.phoneNumber,
      this.birthdate,
      this.idNumber,
      this.providerName,
      this.managerName,
      this.role});

  SupervisorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    gender = json['gender'];
    countryName = json['countryName'];
    nationalityName = json['nationalityName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    birthdate = json['birthdate'];
    idNumber = json['idNumber'];
    providerName = json['providerName'];
    managerName = json['managerName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
    data['gender'] = gender;
    data['countryName'] = countryName;
    data['nationalityName'] = nationalityName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['birthdate'] = birthdate;
    data['idNumber'] = idNumber;
    data['providerName'] = providerName;
    data['managerName'] = managerName;
    data['role'] = role;
    return data;
  }
}
