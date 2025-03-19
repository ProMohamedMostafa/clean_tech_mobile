class DeletedCategoryListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  List<Data>? data;

  DeletedCategoryListModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  DeletedCategoryListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? parentCategoryId;
  String? parentCategoryName;
  String? unit;

  Data(
      {this.id,
      this.name,
      this.parentCategoryId,
      this.parentCategoryName,
      this.unit});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentCategoryId = json['parentCategoryId'];
    parentCategoryName = json['parentCategoryName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parentCategoryId'] = parentCategoryId;
    data['parentCategoryName'] = parentCategoryName;
    data['unit'] = unit;
    return data;
  }
}
