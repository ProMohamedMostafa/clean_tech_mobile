class ProfileModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  ProfileModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  int? gender;
  String? genderName;
  String? countryName;
  String? nationalityName;
  String? email;
  String? phoneNumber;
  String? birthdate;
  String? idNumber;
  String? providerName;
  String? managerName;
  String? role;
  int? roleId;
  int? providerId;
  bool? isWorking;

  Data(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.image,
      this.gender,
      this.genderName,
      this.countryName,
      this.nationalityName,
      this.email,
      this.phoneNumber,
      this.birthdate,
      this.idNumber,
      this.providerName,
      this.managerName,
      this.role,
      this.roleId,
      this.providerId,
      this.isWorking});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    gender = json['gender'];
    genderName = json['genderName'];
    countryName = json['countryName'];
    nationalityName = json['nationalityName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    birthdate = json['birthdate'];
    idNumber = json['idNumber'];
    providerName = json['providerName'];
    managerName = json['managerName'];
    role = json['role'];
    roleId = json['roleId'];
    providerId = json['providerId'];
    isWorking = json['isWorking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
    data['gender'] = gender;
    data['genderName'] = genderName;
    data['countryName'] = countryName;
    data['nationalityName'] = nationalityName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['birthdate'] = birthdate;
    data['idNumber'] = idNumber;
    data['providerName'] = providerName;
    data['managerName'] = managerName;
    data['role'] = role;
    data['roleId'] = roleId;
    data['providerId'] = providerId;
    data['isWorking'] = isWorking;
    return data;
  }
}
