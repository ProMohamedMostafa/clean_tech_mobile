class UserModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  UserModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  String? birthdate;
  int? managerId;
  String? idNumber;
  String? nationalityName;
  String? countryName;
  String? providerName;
  String? gender;
  int? id;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.image,
      this.birthdate,
      this.managerId,
      this.idNumber,
      this.nationalityName,
      this.countryName,
      this.providerName,
      this.gender,
      this.id,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    birthdate = json['birthdate'];
    managerId = json['managerId'];
    idNumber = json['idNumber'];
    nationalityName = json['nationalityName'];
    countryName = json['countryName'];
    providerName = json['providerName'] ?? "providerName";
    gender = json['gender'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    data['birthdate'] = birthdate;
    data['managerId'] = managerId;
    data['idNumber'] = idNumber;
    data['nationalityName'] = nationalityName;
    data['countryName'] = countryName;
    data['providerName'] = providerName;
    data['gender'] = gender;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
