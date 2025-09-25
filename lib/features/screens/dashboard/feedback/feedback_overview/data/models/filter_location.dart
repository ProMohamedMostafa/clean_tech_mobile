class FilterLocationModel {
  int? areaId;
  int? cityId;
  int? organizationId;
  int? buildingId;
  int? floorId;

  FilterLocationModel({
    this.areaId,
    this.cityId,
    this.organizationId,
    this.buildingId,
    this.floorId,
  });

  factory FilterLocationModel.empty() => FilterLocationModel();

  factory FilterLocationModel.fromJson(Map<String, dynamic> json) {
    return FilterLocationModel(
      areaId: json['areaId'],
      cityId: json['cityId'],
      organizationId: json['organizationId'],
      buildingId: json['buildingId'],
      floorId: json['floorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'areaId': areaId,
      'cityId': cityId,
      'organizationId': organizationId,
      'buildingId': buildingId,
      'floorId': floorId,
    };
  }
}
