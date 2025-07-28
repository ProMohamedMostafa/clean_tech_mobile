class DeletedCategoryListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  List<DeletedCategory>? data;

  DeletedCategoryListModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory DeletedCategoryListModel.fromJson(Map<String, dynamic> json) {
    return DeletedCategoryListModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null
          ? List<DeletedCategory>.from(
              json['data'].map((x) => DeletedCategory.fromJson(x)))
          : [],
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
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class DeletedCategory {
  int? id;
  String? name;
  int? parentCategoryId;
  String? parentCategoryName;
  String? unit;
  int? unitId;

  DeletedCategory({
    this.id,
    this.name,
    this.parentCategoryId,
    this.parentCategoryName,
    this.unit,
    this.unitId,
  });

  factory DeletedCategory.fromJson(Map<String, dynamic> json) {
    return DeletedCategory(
      id: json['id'],
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
      parentCategoryName: json['parentCategoryName'],
      unit: json['unit'],
      unitId: json['unitId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentCategoryId': parentCategoryId,
      'parentCategoryName': parentCategoryName,
      'unit': unit,
      'unitId': unitId,
    };
  }
}
