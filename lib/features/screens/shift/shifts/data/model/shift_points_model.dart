class ShiftPointsModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  List<ShiftPoint>? data;

  ShiftPointsModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.data,
  });

  ShiftPointsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<ShiftPoint>.from(
          json['data'].map((v) => ShiftPoint.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['succeeded'] = succeeded;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class ShiftPoint {
  int? id;
  String? name;
  String? floorName;

  ShiftPoint({
    this.id,
    this.name,
    this.floorName,
  });

  ShiftPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    floorName = json['floorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['floorName'] = floorName;
    return result;
  }
}
