class ShiftsCountModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  ShiftsCountModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  ShiftsCountModel.fromJson(Map<String, dynamic> json) {
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
  int? totalCount;
  int? activeCount;
  int? inactiveCount;
  num? activePercentage;

  Data(
      {this.totalCount,
      this.activeCount,
      this.inactiveCount,
      this.activePercentage});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    activeCount = json['activeCount'];
    inactiveCount = json['inactiveCount'];
    activePercentage = json['activePercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['activeCount'] = activeCount;
    data['inactiveCount'] = inactiveCount;
    data['activePercentage'] = activePercentage;
    return data;
  }
}
