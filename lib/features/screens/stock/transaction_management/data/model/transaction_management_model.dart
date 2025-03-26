class TransactionManagementModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final TransactionData? data;

  TransactionManagementModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    this.data,
  });

  factory TransactionManagementModel.fromJson(Map<String, dynamic> json) {
    return TransactionManagementModel(
      statusCode: json['statusCode'] ?? 0,
      succeeded: json['succeeded'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? TransactionData.fromJson(json['data']) : null,
    );
  }
}

class TransactionData {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final bool succeeded;
  final List<TransactionItem> transactions;

  TransactionData({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.succeeded,
    required this.transactions,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? false,
      succeeded: json['succeeded'] ?? false,
      transactions: (json['data'] as List<dynamic>?)
              ?.map((item) => TransactionItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class TransactionItem {
  final int id;
  final String name;
  final String date;
  final String category;
  final int categoryId;
  final String provider;
  final int providerId;
  final double? quantity;
  final double? price;
  final double? totalPrice;
  final String? file;
  final String userName;
  final int userId;
  final int typeId;
  final String type;
  final int? unit;

  TransactionItem({
    required this.id,
    required this.name,
    required this.date,
    required this.category,
    required this.categoryId,
    required this.provider,
    required this.providerId,
    this.quantity,
    this.price,
    this.totalPrice,
    this.file,
    required this.userName,
    required this.userId,
    required this.typeId,
    required this.type,
    this.unit,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      category: json['category'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      provider: json['provider'] ?? '',
      providerId: json['providerId'] ?? 0,
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      totalPrice: json['totalPrice'] != null
          ? (json['totalPrice'] as num).toDouble()
          : null,
      file: json['file'],
      userName: json['userName'] ?? '',
      userId: json['userId'] ?? 0,
      typeId: json['typeId'] ?? 0,
      type: json['type'] ?? '',
      unit: json['unit'],
    );
  }
}
