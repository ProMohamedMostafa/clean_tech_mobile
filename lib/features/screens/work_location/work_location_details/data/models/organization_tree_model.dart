class OrganizationTreeModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<Section>? sections;

  Floors({this.id, this.name, this.previousName, this.sections});

  Floors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previousName = json['previousName'];
    if (json['sections'] != null) {
      sections = <Section>[];
      json['sections'].forEach((v) {
        sections!.add(Section.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['previousName'] = previousName;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Section {
  final int? id;
  final String? name;
  final String? previousName;
  final List<Point>? points;

  Section({
    this.id,
    this.name,
    this.previousName,
    this.points,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        points: json['points'] == null
            ? null
            : List<Point>.from(json['points'].map((x) => Point.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'points': points == null
            ? null
            : List<dynamic>.from(points!.map((x) => x.toJson())),
      };
}

class Point {
  final int? id;
  final String? name;
  final String? previousName;
  final Device? device;

  Point({
    this.id,
    this.name,
    this.previousName,
    this.device,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        id: json['id'],
        name: json['name'],
        previousName: json['previousName'],
        device: json['device'] == null ? null : Device.fromJson(json['device']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previousName': previousName,
        'device': device?.toJson(),
      };
}

class Device {
  final int? id;
  final String? name;

  Device({
    this.id,
    this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
