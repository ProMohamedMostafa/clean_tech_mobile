class UserWorkLocationDetailsModel {
  final int? statusCode;
  final dynamic meta;
  final bool? succeeded;
  final String? message;
  final dynamic error;
  final WorkLocationDetailsData? data;

  UserWorkLocationDetailsModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory UserWorkLocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserWorkLocationDetailsModel(
      statusCode: json['statusCode'] as int?,
      meta: json['meta'],
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'],
      data: json['data'] != null
          ? WorkLocationDetailsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'data': data?.toJson(),
    };
  }
}

class WorkLocationDetailsData {
  final List<dynamic>? areas;
  final List<dynamic>? cities;
  final List<dynamic>? organizations;
  final List<dynamic>? buildings;
  final List<dynamic>? floors;
  final List<dynamic>? points;

  WorkLocationDetailsData({
    this.areas,
    this.cities,
    this.organizations,
    this.buildings,
    this.floors,
    this.points,
  });

  factory WorkLocationDetailsData.fromJson(Map<String, dynamic> json) {
    return WorkLocationDetailsData(
      areas: json['areas'] as List<dynamic>?,
      cities: json['cities'] as List<dynamic>?,
      organizations: json['organizations'] as List<dynamic>?,
      buildings: json['buildings'] as List<dynamic>?,
      floors: json['floors'] as List<dynamic>?,
      points: json['points'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'areas': areas,
      'cities': cities,
      'organizations': organizations,
      'buildings': buildings,
      'floors': floors,
      'points': points,
    };
  }
}
