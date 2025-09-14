import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/data/model/audit_location.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/data/model/audit_location_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/data/model/auditor_history_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/data/all_question_model.dart';

part 'auditor_state.dart';

class AuditorCubit extends Cubit<AuditorState> {
  AuditorCubit() : super(AuditorInitial());

  TextEditingController searchController = TextEditingController();
  Map<int, TextEditingController> textControllers = {};
  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  AuditLocationModel? auditLocationModel;

  getAuditLocation() {
    emit(AuditLocationLoadingState());
    DioHelper.getData(url: "sections/auditor/pagination", query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'SearchQuery': searchController.text,
      // 'OrganizationId': filterModel?.sectionId,
      // 'BuildingId': filterModel?.isAsign
      // 'FloorId': filterModel?.isAsign
    }).then((value) {
      final newDevices = AuditLocationModel.fromJson(value!.data);

      if (currentPage == 1 || auditLocationModel == null) {
        auditLocationModel = newDevices;
      } else {
        auditLocationModel?.data?.data?.addAll(newDevices.data?.data ?? []);
        auditLocationModel?.data?.currentPage = newDevices.data?.currentPage;
        auditLocationModel?.data?.totalPages = newDevices.data?.totalPages;
      }
      emit(AuditLocationSuccessState(auditLocationModel!));
    }).catchError((error) {
      emit(AuditLocationErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAuditLocation();
        }
      });
    getAuditLocation();
  }

  AuditLocationDetailsModel? auditLocationDetailsModel;
  getAuditLocationDetails(int id) {
    emit(AuditLocationDetailsLoadingState());
    DioHelper.getData(url: "sections/$id").then((value) {
      auditLocationDetailsModel =
          AuditLocationDetailsModel.fromJson(value!.data);
      emit(AuditLocationDetailsSuccessState(auditLocationDetailsModel!));
    }).catchError((error) {
      emit(AuditLocationDetailsErrorState(error.toString()));
    });
  }

  bool descTextShowFlag = false;
  void toggleDescText() {
    descTextShowFlag = !descTextShowFlag;
    emit(DescToggleState());
  }

  AuditorHistoryModel? auditorHistory;
  getAuditorhistory(int id) {
    emit(AuditorHistoryLoadingState());
    DioHelper.getData(url: "audit/answers", query: {'SectionId': id})
        .then((value) {
      auditorHistory = AuditorHistoryModel.fromJson(value!.data);
      emit(AuditorHistorySuccessState(auditorHistory!));
    }).catchError((error) {
      emit(AuditorHistoryErrorState(error.toString()));
    });
  }

  AllQuestionsModel? allQuestionsModel;
  getAuditorQuestions(int id) {
    emit(AuditorQuestionsLoadingState());
    DioHelper.getData(url: "questions", query: {'SectionId': id}).then((value) {
      allQuestionsModel = AllQuestionsModel.fromJson(value!.data);

      emit(AuditorQuestionsSuccessState(allQuestionsModel!));
    }).catchError((error) {
      emit(AuditorQuestionsErrorState(error.toString()));
    });
  }

  List<Map<String, dynamic>> answers = [];
  void setAnswer(int questionId, int typeId, dynamic answer) {
    final existingIndex =
        answers.indexWhere((a) => a['questionId'] == questionId);

    final newAnswer = {
      "questionId": questionId,
      "type": typeId,
      "answer": answer
    };

    if (existingIndex != -1) {
      answers[existingIndex] = newAnswer;
    } else {
      answers.add(newAnswer);
    }
  }

  Future<void> addAuditorAnswer(int sectionId) async {
    emit(AddAuditorAnswerLoadingState());

    final body = {"sectionId": sectionId, "answers": answers};

    DioHelper.postData(
      url: 'audit/answers',
      data: body,
    ).then((value) {
      final message = value?.data['message'] ?? "Operation successfully";

      answers.clear();
      clearTextControllers();
      selectedRatingType = -1;
      emit(AddAuditorAnswerSuccessState(message));
    }).catchError((error) {
      emit(AddAuditorAnswerErrorState(error.toString()));
    });
  }

  int selectedRatingType = -1;
  void answerBoolQuestion(bool value) {
    selectedRatingType = value ? 1 : 0;
    emit(AuditorUpdateState());
  }

  List<Map<String, dynamic>> collectedAnswers = [];

  void selectAnswer(int questionId, dynamic answer) {
    collectedAnswers
        .removeWhere((element) => element['questionId'] == questionId);

    collectedAnswers.add({
      'questionId': questionId,
      'answer': answer,
    });

    emit(AuditorAnswerUpdated());
  }

  TextEditingController getTextController(int questionId, String initialValue) {
    if (!textControllers.containsKey(questionId)) {
      textControllers[questionId] = TextEditingController(text: initialValue);
    } else {
      textControllers[questionId]!.text = initialValue;
    }
    return textControllers[questionId]!;
  }

// Call this to clear all text controllers after submitting
  void clearTextControllers() {
    textControllers.forEach((key, controller) => controller.clear());
    textControllers.clear();
  }



}
