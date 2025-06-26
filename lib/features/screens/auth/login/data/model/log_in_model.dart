class LoginModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  LoginModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'businessErrorCode': businessErrorCode,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? image;
  String? location;
  Map<String, dynamic>? settings;
  String? token;
  String? tokenExpires;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.image,
    this.location,
    this.settings,
    this.token,
    this.tokenExpires,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      image: json['image'],
      location: json['location'],
      settings: json['settings'] ?? {},
      token: json['token'],
      tokenExpires: json['tokenExpires'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'image': image,
      'location': location,
      'settings': settings ?? {},
      'token': token,
      'tokenExpires': tokenExpires,
    };
  }
}
