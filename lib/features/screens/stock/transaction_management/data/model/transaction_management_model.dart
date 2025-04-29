class TransactionManagementModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  TransactionData? data;

  TransactionManagementModel({
     this.statusCode,
    this.meta,
     this.succeeded,
     this.message,
    this.error,
    this.businessErrorCode,
     this.data,
  });

  factory TransactionManagementModel.fromJson(Map<String, dynamic> json) {
    return TransactionManagementModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: TransactionData.fromJson(json['data']),
    );
  }
}

class TransactionData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<TransactionItem>? data;

  TransactionData({
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

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: List<TransactionItem>.from(
        json['data'].map((item) => TransactionItem.fromJson(item)),
      ),
    );
  }
}

class TransactionItem {
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
  int? unitId;

  TransactionItem({
     this.id,
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
     this.unitId,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      category: json['category'],
      categoryId: json['categoryId'],
      provider: json['provider'],
      providerId: json['providerId'],
      quantity: json['quantity'],
      price: json['price']?.toDouble(),
      totalPrice: json['totalPrice']?.toDouble(),
      file: json['file'],
      userName: json['userName'],
      userId: json['userId'],
      typeId: json['typeId'],
      type: json['type'],
      unitId: json['unitId'],
    );
  }
}
