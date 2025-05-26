class ProvidersModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  ProvidersData? data;

  ProvidersModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory ProvidersModel.fromJson(Map<String, dynamic> json) {
    return ProvidersModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: ProvidersData.fromJson(json['data']),
    );
  }
}

class ProvidersData {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  String? meta;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;
  bool? succeeded;
  List<Provider>? providers;

  ProvidersData({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.meta,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
    this.succeeded,
    this.providers,
  });

  factory ProvidersData.fromJson(Map<String, dynamic> json) {
    var providersList = json['data'] as List;
    List<Provider> providers =
        providersList.map((provider) => Provider.fromJson(provider)).toList();

    return ProvidersData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      meta: json['meta'],
      pageSize: json['pageSize'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      succeeded: json['succeeded'],
      providers: providers,
    );
  }
}

class Provider {
  int? id;
  String? name;

  Provider({
    this.id,
    this.name,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'],
    );
  }
}
