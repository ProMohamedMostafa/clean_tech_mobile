class TransactionDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  TransactionDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? category;
  int? categoryId;
  String? provider;
  int? providerId;
  double? quantity;
  double? price;
  double? totalPrice;
  String? file;
  String? userName;
  int? userId;
  int? typeId;
  String? type;
  int? unit;

  Data(
      {this.id,
      this.name,
      this.createdAt,
      this.category,
      this.categoryId,
      this.provider,
      this.providerId,
      this.quantity,
      this.price,
      this.totalPrice,
      this.file,
      this.userName,
      this.userId,
      this.typeId,
      this.type,
      this.unit});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    category = json['category'];
    categoryId = json['categoryId'];
    provider = json['provider'];
    providerId = json['providerId'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    file = json['file'];
    userName = json['userName'];
    userId = json['userId'];
    typeId = json['typeId'];
    type = json['type'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['category'] = category;
    data['categoryId'] = categoryId;
    data['provider'] = provider;
    data['providerId'] = providerId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['file'] = file;
    data['userName'] = userName;
    data['userId'] = userId;
    data['typeId'] = typeId;
    data['type'] = type;
    data['unit'] = unit;
    return data;
  }
}
