class SensorModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  SensorData? data;

  SensorModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? SensorData.fromJson(json['data']) : null,
    );
  }
}

class SensorData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<SensorItem>? data;

  SensorData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.data,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: json['data'] != null
          ? List<SensorItem>.from(
              json['data'].map((x) => SensorItem.fromJson(x)))
          : [],
    );
  }
}

class SensorItem {
  int? id;
  String? name;
  String? description;
  String? applicationName;
  DateTime? lastSeenAt;
  bool? active;
  int? battery;
  int? pointId;
  String? pointName;
  String? sectionName;
  int? sectionId;
  String? floorName;
  int? floorId;
  String? buildingName;
  int? buildingId;
  String? organizationName;
  int? organizationId;
  List<SensorDataEntry>? data;
  SensorLimit? limit;

  SensorItem({
    this.id,
    this.name,
    this.description,
    this.applicationName,
    this.lastSeenAt,
    this.active,
    this.battery,
    this.pointId,
    this.pointName,
    this.sectionName,
    this.sectionId,
    this.floorName,
    this.floorId,
    this.buildingName,
    this.buildingId,
    this.organizationName,
    this.organizationId,
    this.data,
    this.limit,
  });

  factory SensorItem.fromJson(Map<String, dynamic> json) {
    return SensorItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      applicationName: json['applicationName'],
      lastSeenAt: json['lastSeenAt'] != null
          ? DateTime.tryParse(json['lastSeenAt'])?.toLocal()
          : null,
      active: json['active'],
      battery: json['battery'],
      pointId: json['pointId'],
      pointName: json['pointName'],
      sectionName: json['sectionName'],
      sectionId: json['sectionId'],
      floorName: json['floorName'],
      floorId: json['floorId'],
      buildingName: json['buildingName'],
      buildingId: json['buildingId'],
      organizationName: json['organizationName'],
      organizationId: json['organizationId'],
      data: json['data'] != null
          ? List<SensorDataEntry>.from(
              json['data'].map((x) => SensorDataEntry.fromJson(x)))
          : [],
      limit: json['limit'] != null ? SensorLimit.fromJson(json['limit']) : null,
    );
  }
}

class SensorDataEntry {
  String? key;
  dynamic value;

  SensorDataEntry({this.key, this.value});

  factory SensorDataEntry.fromJson(Map<String, dynamic> json) {
    return SensorDataEntry(
      key: json['key'],
      value: json['value'],
    );
  }
}

class SensorLimit {
  String? key;
  num? min;
  num? max;

  SensorLimit({
    this.key,
    this.min,
    this.max,
  });

  factory SensorLimit.fromJson(Map<String, dynamic> json) {
    return SensorLimit(
      key: json['key'],
      min: json['min'],
      max: json['max'],
    );
  }
}
