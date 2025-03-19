class CategoryManagementModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final DataModel data;

  CategoryManagementModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.data,
  });

  factory CategoryManagementModel.fromJson(Map<String, dynamic> json) {
    return CategoryManagementModel(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      message: json['message'],
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final bool succeeded;
  final List<CategoryModel> categories;

  DataModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.succeeded,
    required this.categories,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      categories: (json['data'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final int? parentCategoryId;
  final String? parentCategoryName;
  final String unit;

  CategoryModel({
    required this.id,
    required this.name,
    this.parentCategoryId,
    this.parentCategoryName,
    required this.unit,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
      parentCategoryName: json['parentCategoryName'],
      unit: json['unit'],
    );
  }
}
