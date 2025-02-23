class ProfileModel {
  int? statusCode;
  dynamic meta;
  bool? succeeded;
  String? message;
  dynamic error;
  dynamic businessErrorCode;
  Data? data;

  ProfileModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        meta = json['meta'],
        succeeded = json['succeeded'],
        message = json['message'],
        error = json['error'],
        businessErrorCode = json['businessErrorCode'],
        data = json['data'] != null ? Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'meta': meta,
        'succeeded': succeeded,
        'message': message,
        'error': error,
        'businessErrorCode': businessErrorCode,
        if (data != null) 'data': data!.toJson(),
      };
}

class Data {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  dynamic image;
  String? gender;
  String? countryName;
  String? nationalityName;
  String? email;
  String? phoneNumber;
  String? birthdate;
  String? idNumber;
  dynamic providerName;
  dynamic managerName;
  dynamic role;
  List<dynamic>? shifts;
  List<dynamic>? areas;
  List<dynamic>? cities;
  List<dynamic>? organizations;
  List<dynamic>? buildings;
  List<dynamic>? floors;
  List<dynamic>? points;

  Data({
    this.id,
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
    this.role,
    this.shifts,
    this.areas,
    this.cities,
    this.organizations,
    this.buildings,
    this.floors,
    this.points,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        image = json['image'],
        gender = json['gender'],
        countryName = json['countryName'],
        nationalityName = json['nationalityName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        birthdate = json['birthdate'],
        idNumber = json['idNumber'],
        providerName = json['providerName'],
        managerName = json['managerName'],
        role = json['role'],
        shifts = json['shifts'] ?? [],
        areas = json['areas'] ?? [],
        cities = json['cities'] ?? [],
        organizations = json['organizations'] ?? [],
        buildings = json['buildings'] ?? [],
        floors = json['floors'] ?? [],
        points = json['points'] ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'gender': gender,
        'countryName': countryName,
        'nationalityName': nationalityName,
        'email': email,
        'phoneNumber': phoneNumber,
        'birthdate': birthdate,
        'idNumber': idNumber,
        'providerName': providerName,
        'managerName': managerName,
        'role': role,
        'shifts': shifts,
        'areas': areas,
        'cities': cities,
        'organizations': organizations,
        'buildings': buildings,
        'floors': floors,
        'points': points,
      };
}
