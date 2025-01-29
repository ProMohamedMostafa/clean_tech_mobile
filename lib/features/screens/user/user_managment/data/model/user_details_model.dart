class UserDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  UserDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? role;
  int? roleId;
  String? createdAt;
  String? updatedAt;

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
      this.role,
      this.roleId,
      this.createdAt,
      this.updatedAt});

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
    role = json['role'];
    roleId = json['roleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['role'] = role;
    data['roleId'] = roleId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
