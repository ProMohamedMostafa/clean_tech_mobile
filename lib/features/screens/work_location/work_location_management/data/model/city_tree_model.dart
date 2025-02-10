class CityTreeModel {
  final int? statusCode;
  final dynamic meta;
  final bool? succeeded;
  final String? message;
  final dynamic error;
  final dynamic businessErrorCode;
  final Data? data;

  CityTreeModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  factory CityTreeModel.fromJson(Map<String, dynamic> json) {
    return CityTreeModel(
      statusCode: json['statusCode'],
      meta: json['meta'],
      succeeded: json['succeeded'],
      message: json['message'],
      error: json['error'],
      businessErrorCode: json['businessErrorCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'meta': meta,
      'succeeded': succeeded,
      'message': message,
      'error': error,
      'businessErrorCode': businessErrorCode,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final int? id;
  final String? name;
  final List<Organizations>? organizations;

  Data({this.id, this.name, this.organizations});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      organizations: json['organizations'] != null
          ? List<Organizations>.from(
              json['organizations'].map((x) => Organizations.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organizations': organizations?.map((x) => x.toJson()).toList(),
    };
  }
}

class Organizations {
  final int? id;
  final String? name;
  final List<Buildings>? buildings;

  Organizations({this.id, this.name, this.buildings});

  factory Organizations.fromJson(Map<String, dynamic> json) {
    return Organizations(
      id: json['id'],
      name: json['name'],
      buildings: json['buildings'] != null
          ? List<Buildings>.from(
              json['buildings'].map((x) => Buildings.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buildings': buildings?.map((x) => x.toJson()).toList(),
    };
  }
}

class Buildings {
  final int? id;
  final String? name;
  final List<Floors>? floors;

  Buildings({this.id, this.name, this.floors});

  factory Buildings.fromJson(Map<String, dynamic> json) {
    return Buildings(
      id: json['id'],
      name: json['name'],
      floors: json['floors'] != null
          ? List<Floors>.from(json['floors'].map((x) => Floors.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'floors': floors?.map((x) => x.toJson()).toList(),
    };
  }
}

class Floors {
  final int? id;
  final String? name;
  final List<Points>? points;

  Floors({this.id, this.name, this.points});

  factory Floors.fromJson(Map<String, dynamic> json) {
    return Floors(
      id: json['id'],
      name: json['name'],
      points: json['points'] != null
          ? List<Points>.from(json['points'].map((x) => Points.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'points': points?.map((x) => x.toJson()).toList(),
    };
  }
}

class Points {
  final int? id;
  final String? name;
  final String? floorName;

  Points({this.id, this.name, this.floorName});

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      id: json['id'],
      name: json['name'],
      floorName: json['floorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'floorName': floorName,
    };
  }
}
