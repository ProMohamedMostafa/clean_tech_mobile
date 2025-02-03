class UserWorkLocationDetailsModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  String? businessErrorCode;
  Data? data;

  UserWorkLocationDetailsModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  UserWorkLocationDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Areas>? areas;
  List<Cities>? cities;
  List<Organizations>? organizations;
  List<Buildings>? buildings;
  List<Floors>? floors;
  List<Points>? points;

  Data(
      {this.areas,
      this.cities,
      this.organizations,
      this.buildings,
      this.floors,
      this.points});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
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
    if (areas != null) {
      data['areas'] = areas!.map((v) => v.toJson()).toList();
    }
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
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

class Areas {
  int? id;
  String? name;
  String? countryName;

  Areas({this.id, this.name, this.countryName});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['countryName'] = countryName;
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  String? areaName;

  Cities({this.id, this.name, this.areaName});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaName = json['areaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['areaName'] = areaName;
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
