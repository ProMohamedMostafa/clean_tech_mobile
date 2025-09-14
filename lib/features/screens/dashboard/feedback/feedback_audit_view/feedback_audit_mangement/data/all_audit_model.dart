class AllAuditModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  AuditData? data;

  AllAuditModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  AllAuditModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? AuditData.fromJson(json['data']) : null;
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

class AuditData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<AuditItem>? data;

  AuditData(
      {this.currentPage,
      this.totalPages,
      this.totalCount,
      this.meta,
      this.pageSize,
      this.hasPreviousPage,
      this.hasNextPage,
      this.succeeded,
      this.data});

  AuditData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    meta = json['meta'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    succeeded = json['succeeded'];
    if (json['data'] != null) {
      data = <AuditItem>[];
      json['data'].forEach((v) {
        data!.add(AuditItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['meta'] = meta;
    data['pageSize'] = pageSize;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    data['succeeded'] = succeeded;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuditItem {
  int? id;
  String? name;
  int? sectionId;
  String? sectionName;
  int? floorId;
  int? buildingId;
  int? organizationId;
  String? type;
  int? questionCount;

  AuditItem(
      {this.id,
      this.name,
      this.sectionId,
      this.sectionName,
      this.floorId,
      this.buildingId,
      this.organizationId,
      this.type,
      this.questionCount});

  AuditItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
    floorId = json['floorId'];
    buildingId = json['buildingId'];
    organizationId = json['organizationId'];
    type = json['type'];
    questionCount = json['questionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sectionId'] = sectionId;
    data['sectionName'] = sectionName;
    data['floorId'] = floorId;
    data['buildingId'] = buildingId;
    data['organizationId'] = organizationId;
    data['type'] = type;
    data['questionCount'] = questionCount;
    return data;
  }
}
