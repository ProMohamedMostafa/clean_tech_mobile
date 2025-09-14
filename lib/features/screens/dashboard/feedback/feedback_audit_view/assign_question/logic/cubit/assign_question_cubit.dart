import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/assign_question/data/model/feedback_audit_section_question.dart';
part 'assign_question_state.dart';

class AssignQuestionCubit extends Cubit<AssignQuestionState> {
  AssignQuestionCubit() : super(AssignQuestionInitial());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool initialized = false;

  List<bool> selectedItems = [];
  List<bool> expandedItems = [];
  int currentPage = 1;

  FeedbackAuditSectionQuestionModel? feedbackAuditSectionQuestionModel;
  getQuestionsWithSection(int sectionId, int id) {
    emit(QuestionLoadingState());
    DioHelper.getData(url: "section/question", query: {
      'Search': searchController.text,
      'SectionUsageId': id,
      'SectionId': sectionId,
    }).then((value) {
      final newQuestions =
          FeedbackAuditSectionQuestionModel.fromJson(value!.data);

      if (currentPage == 1 || feedbackAuditSectionQuestionModel == null) {
        feedbackAuditSectionQuestionModel = newQuestions;
        selectedItems =
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false);
        expandedItems =
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false);
      } else {
        feedbackAuditSectionQuestionModel?.data?.data
            ?.addAll(newQuestions.data?.data ?? []);
        selectedItems.addAll(
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false));
        expandedItems.addAll(
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false));
      }

      initializeQuestions();

      emit(QuestionSuccessState());
    }).catchError((error) {
      emit(QuestionErrorState(error.toString()));
    });
  }

  void toggleExpand(int index) {
    expandedItems[index] = !expandedItems[index];
    emit(QuestionToggleSelectAllState());
  }

  void clearControllers() {
    searchController.clear();
  }

  bool checked = false;
  void toggleItem(int index) {
    selectedItems[index] = !selectedItems[index];

    checked = selectedItems.every((e) => e);

    emit(QuestionToggleSelectAllState());
  }

  void toggleSelectAll() {
    checked = !checked;
    for (int i = 0; i < selectedItems.length; i++) {
      selectedItems[i] = checked;
    }
    emit(QuestionToggleSelectAllState());
  }

  bool get hasSelection => selectedItems.contains(true);
  List<int> getSelectedIds() {
    final data = feedbackAuditSectionQuestionModel?.data?.data ?? [];
    final ids = <int>[];

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        final id = data[i].id;
        if (id != null) ids.add(id);
      }
    }

    return ids;
  }

  void assignQuestion(int id) {
    final questionIds = getSelectedIds();
    emit(AssignQuestionLoadingState());
    DioHelper.postData(
      url: 'section/usage/assign/questions',
      data: {
        "sectionUsageId": id,
        "questionIds": questionIds,
      },
    ).then((value) {
      final message = value?.data['message'] ?? "Assigned successfully";

      selectedItems = List.generate(selectedItems.length, (_) => false);
      checked = false;

      emit(AssignQuestionSuccessState(message));
    }).catchError((error) {
      emit(AssignQuestionErrorState(error.toString()));
    });
  }

  void initializeQuestions() {
    if (feedbackAuditSectionQuestionModel?.data?.data == null) return;

    final data = feedbackAuditSectionQuestionModel!.data!.data!;

    selectedItems = List.generate(
      data.length,
      (index) => data[index].isChecked == true,
    );

    checked = selectedItems.every((e) => e);

    emit(QuestionToggleSelectAllState());
  }
}
