class TotalFeedbackModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  TotalFeedbackData? data;

  TotalFeedbackModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  TotalFeedbackModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data =
        json['data'] != null ? TotalFeedbackData.fromJson(json['data']) : null;
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

class TotalFeedbackData {
  List<String>? labels;
  List<int>? valuesFeedback;

  TotalFeedbackData({this.labels, this.valuesFeedback});

  TotalFeedbackData.fromJson(Map<String, dynamic> json) {
    labels = (json['labels'] as List<dynamic>?)?.cast<String>();
    valuesFeedback = (json['values'] as List<dynamic>?)?.cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labels'] = labels;
    data['values'] = valuesFeedback;
    return data;
  }
}
