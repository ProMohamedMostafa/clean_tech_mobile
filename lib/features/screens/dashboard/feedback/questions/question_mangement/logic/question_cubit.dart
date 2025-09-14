import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/data/all_question_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/section_basic_model.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitialState());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final allSectionsController = MultiSelectController<SectionData>();
  final formKey = GlobalKey<FormState>();

  List<int> selectedSectionsIds = [];
  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  AllQuestionsModel? allQuestionsModel;

  List<bool> selectedItems = [];
  List<bool> expandedItems = [];

  getQuestions() {
    emit(QuestionLoadingState());
    DioHelper.getData(url: "questions", query: {
      'PageNumber': currentPage,
      'PageSize': 20,
      'Search': searchController.text,
      'Type': filterModel?.questionTypeId,
      'SectionId': filterModel?.sectionId,
    }).then((value) {
      final newQuestions = AllQuestionsModel.fromJson(value!.data);

      if (currentPage == 1 || allQuestionsModel == null) {
        allQuestionsModel = newQuestions;
        selectedItems =
            List.generate(newQuestions.data?.data?.length ?? 0, (_) => false);
        expandedItems = List.generate(
            newQuestions.data?.data?.length ?? 0, (_) => false); // <-- init
      } else {
        allQuestionsModel?.data?.data?.addAll(newQuestions.data?.data ?? []);
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

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getQuestions();
        }
      });
    getQuestions();
    getSection();
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

  void toggleExpand(int index) {
    expandedItems[index] = !expandedItems[index];
    emit(QuestionToggleSelectAllState());
  }

  bool get hasSelection => selectedItems.contains(true);
  List<int> getSelectedIds() {
    final data = allQuestionsModel?.data?.data ?? [];
    final ids = <int>[];

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        final id = data[i].id;
        if (id != null) ids.add(id);
      }
    }

    return ids;
  }

  deleteQuestion() {
    final ids = getSelectedIds();
    emit(DeleteQuestionLoadingState());

    DioHelper.deleteData(url: 'questions/forcedelete/ids', data: {"ids": ids})
        .then((value) {
      final message = value?.data['message'] ?? "Question deleted successfully";
      emit(DeleteQuestionSuccessState(message!));
    }).catchError((error) {
      emit(DeleteQuestionErrorState(error.toString()));
    });
  }

  SectionBasicModel? sectionModel;
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/basic').then((value) {
      sectionModel = SectionBasicModel.fromJson(value!.data);

      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  void assignQuestion() {
    final sectionIds = selectedSectionsIds;
    final questionIds = getSelectedIds();

    emit(AssignQuestionLoadingState());

    DioHelper.postData(
      url: 'section/question/create',
      data: {
        "sectionIds": sectionIds,
        "questionIds": questionIds,
      },
    ).then((value) {
      final message = value?.data['message'] ?? "Assigned successfully";

      selectedSectionsIds = [];
      allSectionsController.clearAll();
      selectedItems = List.generate(selectedItems.length, (_) => false);
      checked = false;

      emit(AssignQuestionSuccessState(message));
    }).catchError((error) {
      emit(AssignQuestionErrorState(error.toString()));
    });
  }

  Future<void> refresh() async {
    currentPage = 1;
    allQuestionsModel = null;

    emit(QuestionLoadingState());
    await getQuestions();
  }
}
