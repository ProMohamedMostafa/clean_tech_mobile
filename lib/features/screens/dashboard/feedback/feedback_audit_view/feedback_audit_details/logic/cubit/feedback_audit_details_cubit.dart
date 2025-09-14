import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/data/model/feedback_audit_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/data/all_question_model.dart';

part 'feedback_audit_details_state.dart';

class FeedbackAuditDetailsCubit extends Cubit<FeedbackAuditDetailsState> {
  FeedbackAuditDetailsCubit() : super(FeedbackAuditDetailsInitial());
  TextEditingController searchController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();

  FeedbackAuditDetailsModel? feedbackAuditDetailsModel;
  getFeedbackAuditDetails(int selectIndex, int id) {
    emit(FeedbackAuditDetailsLoadingState());
    DioHelper.getData(url: 'section/usage/$id').then((value) {
      feedbackAuditDetailsModel =
          FeedbackAuditDetailsModel.fromJson(value!.data);
      emit(FeedbackAuditDetailsSuccessState(feedbackAuditDetailsModel!));
    }).catchError((error) {
      emit(FeedbackAuditDetailsErrorState(error.toString()));
    });
  }

  AllQuestionsModel? allQuestionsModel;
  getQuestions(int feedbackId) {
    emit(QuestionLoadingState());
    DioHelper.getData(url: "questions", query: {
      'Search': searchController.text,
      'Type': typeIdController.text,
      'SectionUsageId': feedbackId,
    }).then((value) {
      allQuestionsModel = AllQuestionsModel.fromJson(value!.data);
      expandedItems = List.generate(
        allQuestionsModel?.data?.data?.length ?? 0,
        (_) => false,
      );
      emit(QuestionSuccessState());
    }).catchError((error) {
      emit(QuestionErrorState(error.toString()));
    });
  }

  final List<String> items = [
    "Multiple options",
    "Checkbox",
    "Text input",
    "Rating",
    "True or false"
  ];

  List<bool> expandedItems = [];
  void toggleExpand(int index) {
    expandedItems[index] = !expandedItems[index];
    emit(QuestionToggleSelectAllState());
  }

  void updateType(String value) {
    typeController.text = value;
    emit(QuestionToggleSelectAllState());
  }

  void clearControllers() {
    searchController.clear();
    typeController.clear();
    typeIdController.clear();
  }
}
