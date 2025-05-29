class UserDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  UserDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  String? birthdate;
  int? managerId;
  String? managerName;
  String? idNumber;
  String? nationalityName;
  String? countryName;
  int? providerId;
  String? providerName;
  String? gender;
  int? genderId;
  String? role;
  int? roleId;

  Data(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.image,
      this.birthdate,
      this.managerId,
      this.managerName,
      this.idNumber,
      this.nationalityName,
      this.countryName,
      this.providerId,
      this.providerName,
      this.gender,
      this.genderId,
      this.role,
      this.roleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    birthdate = json['birthdate'];
    managerId = json['managerId'];
    managerName = json['managerName'];
    idNumber = json['idNumber'];
    nationalityName = json['nationalityName'];
    countryName = json['countryName'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    gender = json['gender'];
    genderId = json['genderId'];
    role = json['role'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    data['birthdate'] = birthdate;
    data['managerId'] = managerId;
    data['managerName'] = managerName;
    data['idNumber'] = idNumber;
    data['nationalityName'] = nationalityName;
    data['countryName'] = countryName;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['gender'] = gender;
    data['genderId'] = genderId;
    data['role'] = role;
    data['roleId'] = roleId;
    return data;
  }
}
