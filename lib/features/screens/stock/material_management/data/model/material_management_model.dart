class MaterialManagementModel {
  int statusCode;
  String? meta;
  bool succeeded;
  String message;
  String? error;
  int? businessErrorCode;
  MaterialDataModel data;

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
      data: MaterialDataModel.fromJson(json['data']),
    );
  }
}

class MaterialDataModel {
  int currentPage;
  int totalPages;
  int totalCount;
  String? meta;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;
  bool succeeded;
  List<MaterialModel> materials;

  MaterialDataModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.meta,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.succeeded,
    required this.materials,
  });

  factory MaterialDataModel.fromJson(Map<String, dynamic> json) {
    return MaterialDataModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      materials:
          (json['data'] as List).map((e) => MaterialModel.fromJson(e)).toList(),
    );
  }
}

class MaterialModel {
  int id;
  String name;
  double minThreshold;
  String description;
  double quantity;
  int categoryId;
  String categoryName;
  String unit;

  MaterialModel({
    required this.id,
    required this.name,
    required this.minThreshold,
    required this.description,
    required this.quantity,
    required this.categoryId,
    required this.categoryName,
    required this.unit,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      name: json['name'],
      minThreshold: json['minThreshold'],
      description: json['description'],
      quantity: (json['quantity'] as num).toDouble(),
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      unit: json['unit'],
    );
  }
}
