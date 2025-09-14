import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/data/model/point_question.dart';
part 'assign_question_state.dart';

class AssignQuestionPointCubit extends Cubit<AssignQuestionPointState> {
  AssignQuestionPointCubit() : super(AssignQuestionPointInitial());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool initialized = false;

  List<bool> selectedItems = [];
  List<bool> expandedItems = [];

  int currentPage = 1;
  PointQuestionModel? pointQuestionModel;
  getQuestionsSection(int id, int sectionId) {
    emit(QuestionLoadingState());
    DioHelper.getData(url: "questions", query: {
      'Search': searchController.text,
      'SectionId':sectionId,
      'PointId': id,
      'IsHidden': true
    }).then((value) {
      final newQuestions = PointQuestionModel.fromJson(value!.data);

      if (currentPage == 1 || pointQuestionModel == null) {
        pointQuestionModel = newQuestions;
        selectedItems =
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false);
        expandedItems =
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false);
      } else {
        pointQuestionModel?.data?.data?.addAll(newQuestions.data?.data ?? []);
        selectedItems.addAll(
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false));
        expandedItems.addAll(
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false));
      }
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
    final data = pointQuestionModel?.data?.data ?? [];
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
    emit(AssignQuestionPointLoadingState());
    DioHelper.postData(
      url: 'questions/point',
      data: {
        "pointId": id,
        "questionIds": questionIds,
      },
    ).then((value) {
      final message = value?.data['message'] ?? "Assigned successfully";
      selectedItems = List.generate(selectedItems.length, (_) => false);
      checked = false;
      emit(AssignQuestionPointSuccessState(message));
    }).catchError((error) {
      emit(AssignQuestionPointErrorState(error.toString()));
    });
  }

  void initializeQuestions() {
    if (pointQuestionModel?.data?.data == null) return;
    final data = pointQuestionModel!.data!.data!;
    selectedItems = List.generate(
      data.length,
      (index) => data[index].isChecked == true,
    );
    checked = selectedItems.every((e) => e);
    emit(QuestionToggleSelectAllState());
  }
}
