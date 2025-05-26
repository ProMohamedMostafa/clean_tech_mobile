class TotalStockModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  TotalStockData? data;

  TotalStockModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  TotalStockModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? TotalStockData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    data['businessErrorCode'] = businessErrorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TotalStockData {
  List<String>? labels;
  List<int>? valuesStockIn;
  List<int>? valuesStockOut;

  TotalStockData({this.labels, this.valuesStockIn, this.valuesStockOut});

  TotalStockData.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    valuesStockIn = json['valuesStockIn'].cast<int>();
    valuesStockOut = json['valuesStockOut'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labels'] = labels;
    data['valuesStockIn'] = valuesStockIn;
    data['valuesStockOut'] = valuesStockOut;
    return data;
  }
}
