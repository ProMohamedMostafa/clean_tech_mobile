class AuditorLocationCountModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  AuditorLocationCountModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  AuditorLocationCountModel.fromJson(Map<String, dynamic> json) {
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
  int? countArea;
  int? countCity;
  int? countOrganization;
  int? countBuilding;
  int? countFloor;
  int? countSection;

  Data(
      {this.countArea,
      this.countCity,
      this.countOrganization,
      this.countBuilding,
      this.countFloor,
      this.countSection});

  Data.fromJson(Map<String, dynamic> json) {
    countArea = json['countArea'];
    countCity = json['countCity'];
    countOrganization = json['countOrganization'];
    countBuilding = json['countBuilding'];
    countFloor = json['countFloor'];
    countSection = json['countSection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countArea'] = countArea;
    data['countCity'] = countCity;
    data['countOrganization'] = countOrganization;
    data['countBuilding'] = countBuilding;
    data['countFloor'] = countFloor;
    data['countSection'] = countSection;
    return data;
  }
}
