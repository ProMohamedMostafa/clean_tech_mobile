class UsersModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  UserData? data;

  UsersModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class UserData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<UserItem>? users;

  UserData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.users,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      users = (json['data'] as List).map((v) => UserItem.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['meta'] = meta;
    data['pageSize'] = pageSize;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    data['succeeded'] = succeeded;
    if (users != null) {
      data['data'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserItem {
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
  String? createdAt;
  String? updatedAt;

  UserItem({
    this.id,
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
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  UserItem.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
