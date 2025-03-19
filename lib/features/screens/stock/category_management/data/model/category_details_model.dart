class CategoryDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  CategoryDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? parentCategoryId;
  String? parentCategoryName;
  String? unit;
  int? unitId;

  Data(
      {this.id,
      this.name,
      this.parentCategoryId,
      this.parentCategoryName,
      this.unit,
      this.unitId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentCategoryId = json['parentCategoryId'];
    parentCategoryName = json['parentCategoryName'];
    unit = json['unit'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parentCategoryId'] = parentCategoryId;
    data['parentCategoryName'] = parentCategoryName;
    data['unit'] = unit;
    data['unitId'] = unitId;
    return data;
  }
}
