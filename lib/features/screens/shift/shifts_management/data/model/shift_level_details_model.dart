class ShiftLevelDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  Data? data;

  ShiftLevelDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  ShiftLevelDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Organizations>? organizations;
  List<Buildings>? buildings;
  List<Floors>? floors;
  List<Points>? points;

  Data({this.organizations, this.buildings, this.floors, this.points});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['organizations'] != null) {
      organizations = <Organizations>[];
      json['organizations'].forEach((v) {
        organizations!.add(Organizations.fromJson(v));
      });
    }
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(Buildings.fromJson(v));
      });
    }
    if (json['floors'] != null) {
      floors = <Floors>[];
      json['floors'].forEach((v) {
        floors!.add(Floors.fromJson(v));
      });
    }
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organizations != null) {
      data['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    if (buildings != null) {
      data['buildings'] = buildings!.map((v) => v.toJson()).toList();
    }
    if (floors != null) {
      data['floors'] = floors!.map((v) => v.toJson()).toList();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organizations {
  int? id;
  String? name;
  String? cityName;

  Organizations({this.id, this.name, this.cityName});

  Organizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cityName'] = cityName;
    return data;
  }
}

class Buildings {
  int? id;
  String? name;
  String? organizationName;

  Buildings({this.id, this.name, this.organizationName});

  Buildings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizationName = json['organizationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['organizationName'] = organizationName;
    return data;
  }
}

class Floors {
  int? id;
  String? name;
  String? buildingName;

  Floors({this.id, this.name, this.buildingName});

  Floors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    buildingName = json['buildingName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['buildingName'] = buildingName;
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
