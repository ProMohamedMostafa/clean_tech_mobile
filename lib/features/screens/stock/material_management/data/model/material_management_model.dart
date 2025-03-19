class MaterialManagementModel {
  final int statusCode;
  final dynamic meta;
  final bool succeeded;
  final String message;
  final dynamic error;
  final dynamic businessErrorCode;
  final MaterialData data;

  MaterialManagementModel({
    required this.statusCode,
    this.meta,
    required this.succeeded,
    required this.message,
    this.error,
    this.businessErrorCode,
    required this.data,
  });

  factory MaterialManagementModel.fromJson(Map<String, dynamic> json) {
    return MaterialManagementModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: MaterialData.fromJson(json['data']),
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
      'data': data.toJson(),
    };
  }
}

class MaterialData {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final dynamic meta;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final bool succeeded;
  final List<MaterialItem> data;

  MaterialData({
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

  factory MaterialData.fromJson(Map<String, dynamic> json) {
    return MaterialData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: (json['data'] as List)
          .map((item) => MaterialItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalCount': totalCount,
      'meta': meta,
      'pageSize': pageSize,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
      'succeeded': succeeded,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class MaterialItem {
  final int id;
  final String name;
  final double minThreshold;
  final String description;
  final double quantity;
  final int categoryId;
  final String categoryName;

  MaterialItem({
    required this.id,
    required this.name,
    required this.minThreshold,
    required this.description,
    required this.quantity,
    required this.categoryId,
    required this.categoryName,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'],
      name: json['name'],
      minThreshold: json['minThreshold'],
      description: json['description'],
      quantity: json['quantity'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'minThreshold': minThreshold,
      'description': description,
      'quantity': quantity,
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }
}
