class TaskActionModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  List<Data>? data;

  TaskActionModel(
      {this.statusCode,
      this.meta,
      this.succeeded,
      this.message,
      this.error,
      this.data});

  TaskActionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    meta = json['meta'];
    succeeded = json['succeeded'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? status;
  String? comment;
  String? userName;
  int? userId;
  String? image;
  String? role;
  String? createdAt;
  List<Files>? files;
  String? timeDifferenceText;

  Data({
    this.status,
    this.comment,
    this.userName,
    this.userId,
    this.image,
    this.role,
    this.createdAt,
    this.files,
    this.timeDifferenceText,
  });

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    userName = json['userName'];
    userId = json['userId'];
    image = json['image'];
    role = json['role'];
    createdAt = json['createdAt'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    timeDifferenceText = json['timeDifferenceText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['comment'] = comment;
    data['userName'] = userName;
    data['userId'] = userId;
    data['image'] = image;
    data['role'] = role;
    data['createdAt'] = createdAt;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['timeDifferenceText'] = timeDifferenceText;
    return data;
  }
}

class Files {
  int? id;
  String? path;

  Files({this.id, this.path});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    return data;
  }
}
