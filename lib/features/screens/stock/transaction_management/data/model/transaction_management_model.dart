class TransactionManagementModel {
  int statusCode;
  String? meta;
  bool succeeded;
  String message;
  String? error;
  int? businessErrorCode;
  TransactionData data;

  TransactionManagementModel({
    required this.statusCode,
    this.meta,
    required this.succeeded,
    required this.message,
    this.error,
    this.businessErrorCode,
    required this.data,
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
  int currentPage;
  int totalPages;
  int totalCount;
  String? meta;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;
  bool succeeded;
  List<TransactionItem> data;

  TransactionData({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.meta,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.succeeded,
    required this.data,
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
  int id;
  String name;
  String createdAt;
  String category;
  int categoryId;
  String provider;
  int providerId;
  double quantity;
  double? price;
  double? totalPrice;
  String? file;
  String userName;
  int userId;
  int typeId;
  String type;
  int unit;

  TransactionItem({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.category,
    required this.categoryId,
    required this.provider,
    required this.providerId,
    required this.quantity,
    this.price,
    this.totalPrice,
    this.file,
    required this.userName,
    required this.userId,
    required this.typeId,
    required this.type,
    required this.unit,
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
      unit: json['unit'],
    );
  }
}
