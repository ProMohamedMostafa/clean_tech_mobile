class MaterialManagementModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final MaterialData data;

  MaterialManagementModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.data,
  });

  factory MaterialManagementModel.fromJson(Map<String, dynamic> json) {
    return MaterialManagementModel(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      message: json['message'],
      data: MaterialData.fromJson(json['data']),
    );
  }
}

class MaterialData {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final bool succeeded;
  final List<MaterialItem> data;

  MaterialData({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
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
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      data: (json['data'] as List)
          .map((item) => MaterialItem.fromJson(item))
          .toList(),
    );
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
  final String unit;

  MaterialItem({
    required this.id,
    required this.name,
    required this.minThreshold,
    required this.description,
    required this.quantity,
    required this.categoryId,
    required this.categoryName,
    required this.unit,
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
      unit: json['unit'],
    );
  }
}
