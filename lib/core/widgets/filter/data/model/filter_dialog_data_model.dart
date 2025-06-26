class FilterDialogDataModel {
  String? nationality;
  String? country;
  int? areaId;
  int? cityId;
  int? organizationId;
  int? buildingId;
  int? floorId;
  int? sectionId;
  int? pointId;
  int? providerId;
  int? roleId;
  int? typeId;
  int? genderId;
  int? userId;
  int? shiftId;
  int? statusId;
  int? taskStatusId;
  int? priorityId;
  int? createdBy;
  int? assignTo;
  int? actionId;
  int? moduleId;
  int? unitId;
  int? categoryId;
  int? transactionTypeId;
  int? applicationId;
  String? activityStatus;
  int? minBattery;
  int? maxBattery;
  int? deviceId;
  DateTime? date;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? isAsign;

  FilterDialogDataModel({
    this.nationality,
    this.country,
    this.areaId,
    this.cityId,
    this.organizationId,
    this.buildingId,
    this.floorId,
    this.sectionId,
    this.pointId,
    this.providerId,
    this.roleId,
    this.typeId,
    this.genderId,
    this.userId,
    this.shiftId,
    this.statusId,
    this.taskStatusId,
    this.priorityId,
    this.createdBy,
    this.moduleId,
    this.unitId,
    this.categoryId,
    this.actionId,
    this.assignTo,
    this.transactionTypeId,
    this.applicationId,
    this.activityStatus,
    this.minBattery,
    this.maxBattery,
    this.deviceId,
    this.date,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.isAsign,
  });

  factory FilterDialogDataModel.empty() => FilterDialogDataModel();

  factory FilterDialogDataModel.fromJson(Map<String, dynamic> json) {
    return FilterDialogDataModel(
      nationality: json['nationality'],
      country: json['country'],
      areaId: json['areaId'],
      cityId: json['cityId'],
      organizationId: json['organizationId'],
      buildingId: json['buildingId'],
      floorId: json['floorId'],
      sectionId: json['sectionId'],
      pointId: json['pointId'],
      providerId: json['providerId'],
      roleId: json['roleId'],
      typeId: json['typeId'],
      genderId: json['genderId'],
      userId: json['userId'],
      shiftId: json['shiftId'],
      statusId: json['statusId'],
      taskStatusId: json['taskStatusId'],
      priorityId: json['priorityId'],
      createdBy: json['createdBy'],
      assignTo: json['assignTo'],
      moduleId: json['moduleId'],
      actionId: json['actionId'],
      unitId: json['unitId'],
      categoryId: json['categoryId'],
      transactionTypeId: json['transactionTypeId'],
      applicationId: json['applicationId'],
      activityStatus: json['activityStatus'],
      minBattery: json['minBattery'],
      maxBattery: json['maxBattery'],
      deviceId: json['deviceId'],
      date: json['date'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isAsign: json['isAsign'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nationality': nationality,
      'country': country,
      'areaId': areaId,
      'cityId': cityId,
      'organizationId': organizationId,
      'buildingId': buildingId,
      'floorId': floorId,
      'sectionId': sectionId,
      'pointId': pointId,
      'providerId': providerId,
      'roleId': roleId,
      'typeId': typeId,
      'genderId': genderId,
      'userId': userId,
      'shiftId': shiftId,
      'statusId': statusId,
      'taskStatusId': taskStatusId,
      'priorityId': priorityId,
      'createdBy': createdBy,
      'assignTo': assignTo,
      'actionId': actionId,
      'moduleId': moduleId,
      'unitId': unitId,
      'categoryId': categoryId,
      'transactionTypeId': transactionTypeId,
      'applicationId': applicationId,
      'activityStatus': activityStatus,
      'minBattery': minBattery,
      'maxBattery': maxBattery,
      'deviceId': deviceId,
      'date': date,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'isAsign': isAsign,
    };
  }
}
