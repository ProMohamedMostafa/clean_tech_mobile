class FeedbackAnswerModel {
  int? statusCode;
  String? meta;
  bool? succeeded;
  String? message;
  String? error;
  int? businessErrorCode;
  Data? data;

  FeedbackAnswerModel({
    this.statusCode,
    this.meta,
    this.succeeded,
    this.message,
    this.error,
    this.businessErrorCode,
    this.data,
  });

  FeedbackAnswerModel.fromJson(Map<String, dynamic> json) {
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
    if (this.data != null) data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String? buildingName;
  String? floorName;
  String? sectionName;
  String? date;
  String? time;
  int? totalQuestionCount;
  int? completedQuestionCount;
  List<Questions>? questions;

  Data({
    this.buildingName,
    this.floorName,
    this.sectionName,
    this.date,
    this.time,
    this.totalQuestionCount,
    this.completedQuestionCount,
    this.questions,
  });

  Data.fromJson(Map<String, dynamic> json) {
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    sectionName = json['sectionName'];
    date = json['date'];
    time = json['time'];
    totalQuestionCount = json['totalQuestionCount'];
    completedQuestionCount = json['completedQuestionCount'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buildingName'] = buildingName;
    data['floorName'] = floorName;
    data['sectionName'] = sectionName;
    data['date'] = date;
    data['time'] = time;
    data['totalQuestionCount'] = totalQuestionCount;
    data['completedQuestionCount'] = completedQuestionCount;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  String? questionText;
  String? type;
  int? typeId;
  List<Choices>? choices;
  int? reason;
  String? reasonName;
  String? textAnswer; // typeId == 2
  int? rateAnswer; // typeId == 3
  bool? boolAnswer; // typeId == 4
  int? choiceIdAnswer; // typeId == 0
  List<int>? choiceIdsAnswer; // typeId == 1  <<< FIXED TYPE
  bool? isAnswered;

  Questions({
    this.id,
    this.questionText,
    this.type,
    this.typeId,
    this.reason,
    this.reasonName,
    this.choices,
    this.textAnswer,
    this.rateAnswer,
    this.boolAnswer,
    this.choiceIdAnswer,
    this.choiceIdsAnswer,
    this.isAnswered,
  });

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['questionText'];
    type = json['type'];
    typeId = json['typeId'];
    reason = json['reason'];
    reasonName = json['reasonName'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    textAnswer = json['textAnswer'];
    rateAnswer = json['rateAnswer'];
    boolAnswer = json['boolAnswer'];
    choiceIdAnswer = json['choiceIdAnswer'];

    // Robust parsing for choiceIdsAnswer
    final raw = json['choiceIdsAnswer'];
    if (raw is List) {
      // e.g., [1,2,3]
      choiceIdsAnswer = raw.whereType<num>().map((e) => e.toInt()).toList();
    } else if (raw is String) {
      // e.g., "1,2,3"
      choiceIdsAnswer = raw
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .map((e) => int.tryParse(e))
          .whereType<int>()
          .toList();
      if (choiceIdsAnswer!.isEmpty) choiceIdsAnswer = null;
    } else if (raw is num) {
      // e.g., single number
      choiceIdsAnswer = [raw.toInt()];
    } else {
      choiceIdsAnswer = null;
    }

    isAnswered = json['isAnswered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['questionText'] = questionText;
    data['type'] = type;
    data['typeId'] = typeId;
    data['reason'] = reason;
    data['reasonName'] = reasonName;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    data['textAnswer'] = textAnswer;
    data['rateAnswer'] = rateAnswer;
    data['boolAnswer'] = boolAnswer;
    data['choiceIdAnswer'] = choiceIdAnswer;
    data['choiceIdsAnswer'] = choiceIdsAnswer;
    data['isAnswered'] = isAnswered;
    return data;
  }
}

class Choices {
  int? id;
  String? text;
  String? image;
  String? icon;

  Choices({this.id, this.text, this.image, this.icon});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    image = json['image'];
    icon = json['icon']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['image'] = image;
    data['icon'] = icon;
    return data;
  }
}
