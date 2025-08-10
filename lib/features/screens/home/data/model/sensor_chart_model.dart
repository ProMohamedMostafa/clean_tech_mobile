class SensorChartModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  SensorChartModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.businessErrorCode,
      this.data});

  SensorChartModel.fromJson(Map<String, dynamic> json) {
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
  List<GetCompletionDeviceTask>? getCompletionDeviceTask;
  Status? status;
  num? totalCompletionPercentage;

  Data(
      {this.getCompletionDeviceTask,
      this.status,
      this.totalCompletionPercentage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getCompletionDeviceTask'] != null) {
      getCompletionDeviceTask = <GetCompletionDeviceTask>[];
      json['getCompletionDeviceTask'].forEach((v) {
        getCompletionDeviceTask!.add(GetCompletionDeviceTask.fromJson(v));
      });
    }
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    totalCompletionPercentage = json['totalCompletionPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCompletionDeviceTask != null) {
      data['getCompletionDeviceTask'] =
          getCompletionDeviceTask!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['totalCompletionPercentage'] = totalCompletionPercentage;
    return data;
  }
}

class GetCompletionDeviceTask {
  int? id;
  String? name;
  int? battery;
  int? totalTasks;
  int? completedTasks;
  num? completionPercentage;

  GetCompletionDeviceTask(
      {this.id,
      this.name,
      this.battery,
      this.totalTasks,
      this.completedTasks,
      this.completionPercentage});

  GetCompletionDeviceTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    battery = json['battery'];
    totalTasks = json['totalTasks'];
    completedTasks = json['completedTasks'];
    completionPercentage = json['completionPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['battery'] = battery;
    data['totalTasks'] = totalTasks;
    data['completedTasks'] = completedTasks;
    data['completionPercentage'] = completionPercentage;
    return data;
  }
}

class Status {
  num? pendingPercentage;
  num? inProgressPercentage;
  num? completedPercentage;
  num? overduePercentage;

  Status(
      {this.pendingPercentage,
      this.inProgressPercentage,
      this.completedPercentage,
      this.overduePercentage});

  Status.fromJson(Map<String, dynamic> json) {
    pendingPercentage = json['pendingPercentage'];
    inProgressPercentage = json['inProgressPercentage'];
    completedPercentage = json['completedPercentage'];
    overduePercentage = json['overduePercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pendingPercentage'] = pendingPercentage;
    data['inProgressPercentage'] = inProgressPercentage;
    data['completedPercentage'] = completedPercentage;
    data['overduePercentage'] = overduePercentage;
    return data;
  }
}
