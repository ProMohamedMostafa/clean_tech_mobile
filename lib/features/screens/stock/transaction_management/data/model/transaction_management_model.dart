class TransactionManagementModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final TransactionData data;

  TransactionManagementModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.data,
  });

  factory TransactionManagementModel.fromJson(Map<String, dynamic> json) {
    return TransactionManagementModel(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      message: json['message'],
      data: TransactionData.fromJson(json['data']),
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
  final List<TransactionItem> data;

  TransactionData({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
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
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: (json['data'] as List)
          .map((item) => TransactionItem.fromJson(item))
          .toList(),
    );
  }
}

class TransactionItem {
  final String name;
  final String date;
  final String category;
  final int categoryId;
  final String provider;
  final int providerId;
  final double quantity;
  final double price;
  final double totalPrice;
  final String? file;
  final String userName;
  final int userId;
  final int typeId;
  final String type;
  final String? unit;

  TransactionItem({
    required this.name,
    required this.date,
    required this.category,
    required this.categoryId,
    required this.provider,
    required this.providerId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.file,
    required this.userName,
    required this.userId,
    required this.typeId,
    required this.type,
    required this.unit,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      name: json['name'],
      date: json['date'],
      category: json['category'],
      categoryId: json['categoryId'],
      provider: json['provider'],
      providerId: json['providerId'],
      quantity: json['quantity'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      file: json['file'],
      userName: json['userName'],
      userId: json['userId'],
      typeId: json['typeId'],
      type: json['type'],
      unit: json['unit'],
    );
  }
}
