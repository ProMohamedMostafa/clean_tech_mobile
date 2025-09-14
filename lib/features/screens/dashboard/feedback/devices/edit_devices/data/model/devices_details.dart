class DeviceDetails {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  DeviceDetails(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? sectionId;
  String? sectionName;
  int? floorId;
  String? floorName;
  int? buildingId;
  String? buildingName;
  int? questionCount;
  String? feedbackName;

  Data(
      {this.id,
      this.name,
      this.sectionId,
      this.sectionName,
      this.floorId,
      this.floorName,
      this.buildingId,
      this.buildingName,
      this.questionCount,
      this.feedbackName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    questionCount = json['questionCount'];
    feedbackName = json['feedbackName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sectionId'] = sectionId;
    data['sectionName'] = sectionName;
    data['floorId'] = floorId;
    data['floorName'] = floorName;
    data['buildingId'] = buildingId;
    data['buildingName'] = buildingName;
    data['questionCount'] = questionCount;
    data['feedbackName'] = feedbackName;
    return data;
  }
}
