class CategoryManagementModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  DataModel? data;

  CategoryManagementModel({
     this.statusCode,
    this.meta,
     this.succeeded,
     this.message,
    this.error,
    this.businessErrorCode,
     this.data,
  });

  factory CategoryManagementModel.fromJson(Map<String, dynamic> json) {
    return CategoryManagementModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<CategoryModel>? categories;

  DataModel({
     this.currentPage,
     this.totalPages,
     this.totalCount,
    this.meta,
     this.pageSize,
     this.hasPreviousPage,
     this.hasNextPage,
     this.succeeded,
     this.categories,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      categories:
          (json['data'] as List).map((e) => CategoryModel.fromJson(e)).toList(),
    );
  }
}

class CategoryModel {
  int? id;
  String? name;
  int? parentCategoryId;
  String? parentCategoryName;
  String? unit;
  int? unitId;

  CategoryModel({
     this.id,
     this.name,
    this.parentCategoryId,
    this.parentCategoryName,
     this.unit,
     this.unitId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
      parentCategoryName: json['parentCategoryName'],
      unit: json['unit'],
      unitId: json['unitId'],
    );
  }
}
