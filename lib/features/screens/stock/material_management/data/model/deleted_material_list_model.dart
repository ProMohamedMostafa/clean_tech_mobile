class DeletedMaterialListModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  List<Data>? data;

  DeletedMaterialListModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  DeletedMaterialListModel.fromJson(Map<String, dynamic> json) {
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
  double? minThreshold;
  String? description;
  double? quantity;
  int? categoryId;
  String? categoryName;
  String? unit;

  Data(
      {this.id,
      this.name,
      this.minThreshold,
      this.description,
      this.quantity,
      this.categoryId,
      this.categoryName,
      this.unit});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minThreshold = json['minThreshold'];
    description = json['description'];
    quantity = json['quantity'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['minThreshold'] = minThreshold;
    data['description'] = description;
    data['quantity'] = quantity;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['unit'] = unit;
    return data;
  }
}
