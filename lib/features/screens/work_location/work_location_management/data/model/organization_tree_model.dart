// ignore_for_file: prefer_collection_literals

class OrganizationTreeModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  OrganizationTreeModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  OrganizationTreeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    businessErrorCode = json['businessErrorCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? name;
  String? previousName;
  List<Buildings>? buildings;

  Data({this.id, this.name, this.previousName, this.buildings});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previousName = json['previousName'];
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(Buildings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['previousName'] = previousName;
    if (buildings != null) {
      data['buildings'] = buildings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buildings {
  int? id;
  String? name;
  String? previousName;
  List<Floors>? floors;

  Buildings({this.id, this.name, this.previousName, this.floors});

  Buildings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previousName = json['previousName'];
    if (json['floors'] != null) {
      floors = <Floors>[];
      json['floors'].forEach((v) {
        floors!.add(Floors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['previousName'] = previousName;
    if (floors != null) {
      data['floors'] = floors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Floors {
  int? id;
  String? name;
  String? previousName;
  List<Points>? points;

  Floors({this.id, this.name, this.previousName, this.points});

  Floors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previousName = json['previousName'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['previousName'] = previousName;
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  int? id;
  String? name;
  String? floorName;

  Points({this.id, this.name, this.floorName});

  Points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    floorName = json['floorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['floorName'] = floorName;
    return data;
  }
}
