import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/data/all_audit_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/data/all_feedback_model.dart';

part 'feedback_audit_state.dart';

class FeedbackAuditCubit extends Cubit<FeedbackAuditState> {
  FeedbackAuditCubit() : super(FeedbackAuditInitialState());

  TextEditingController searchController = TextEditingController();
  ScrollController feedbackScrollController = ScrollController();
  ScrollController auditScrollController = ScrollController();

  int selectedIndex = 0;
  FilterDialogDataModel? filterModel;

  int feedbackCurrentPage = 1;
  AllFeedbackModel? allFeedbackModel;

  int auditCurrentPage = 1;
  AllAuditModel? allAuditModel;

  // ========================= FEEDBACK =========================
  Future<void> getAllFeedback() async {
    emit(FeedbackAuditLoadingState());

    try {
      final value = await DioHelper.getData(url: "section/usage", query: {
        'PageNumber': feedbackCurrentPage,
        'PageSize': 20,
        'Search': searchController.text,
        'SectionId': filterModel?.sectionId,
        'Type': 0,
      });

      final newFeedback = AllFeedbackModel.fromJson(value!.data);

      if (feedbackCurrentPage == 1 || allFeedbackModel == null) {
        allFeedbackModel = newFeedback;
      } else {
        allFeedbackModel?.data?.data?.addAll(newFeedback.data?.data ?? []);
        allFeedbackModel?.data?.currentPage = newFeedback.data?.currentPage;
        allFeedbackModel?.data?.totalPages = newFeedback.data?.totalPages;
      }

      emit(FeedbackAuditSuccessState(allFeedbackModel!));
    } catch (error) {
      emit(FeedbackAuditErrorState(error.toString()));
    }
  }

  // ========================= AUDIT =========================
  Future<void> getAllAudit() async {
    emit(FeedbackAuditLoadingState());

    try {
      final value = await DioHelper.getData(url: "section/usage", query: {
        'PageNumber': auditCurrentPage,
        'PageSize': 15,
        'Search': searchController.text,
        'SectionId': filterModel?.sectionId,
        'Type': 1,
      });

      final newAudit = AllAuditModel.fromJson(value!.data);

      if (auditCurrentPage == 1 || allAuditModel == null) {
        allAuditModel = newAudit;
      } else {
        allAuditModel?.data?.data?.addAll(newAudit.data?.data ?? []);
        allAuditModel?.data?.currentPage = newAudit.data?.currentPage;
        allAuditModel?.data?.totalPages = newAudit.data?.totalPages;
      }

      emit(FeedbackAuditSuccessState(allAuditModel!));
    } catch (error) {
      emit(FeedbackAuditErrorState(error.toString()));
    }
  }

  // ========================= INIT =========================
  void initialize() {
    // feedback scroll
    feedbackScrollController = ScrollController()
      ..addListener(() {
        if (feedbackScrollController.position.atEdge &&
            feedbackScrollController.position.pixels != 0) {
          if ((allFeedbackModel?.data?.currentPage ?? 1) <
              (allFeedbackModel?.data?.totalPages ?? 1)) {
            feedbackCurrentPage++;
            getAllFeedback();
          }
        }
      });

    // audit scroll
    auditScrollController = ScrollController()
      ..addListener(() {
        if (auditScrollController.position.atEdge &&
            auditScrollController.position.pixels != 0) {
          if ((allAuditModel?.data?.currentPage ?? 1) <
              (allAuditModel?.data?.totalPages ?? 1)) {
            auditCurrentPage++;
            getAllAudit();
          }
        }
      });

    getAllFeedback();
    getAllAudit();
  }

  // ========================= TABS =========================
  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (allFeedbackModel == null) {
        feedbackCurrentPage = 1;
        getAllFeedback();
      } else {
        emit(FeedbackAuditSuccessState(allFeedbackModel!));
      }
    } else {
      if (allAuditModel == null) {
        auditCurrentPage = 1;
        getAllAudit();
      } else {
        emit(FeedbackAuditSuccessState(allAuditModel!));
      }
    }
  }

  // ========================= REFRESH =========================
  Future<void> refresh() async {
    feedbackCurrentPage = 1;
    auditCurrentPage = 1;
    allFeedbackModel = null;
    allAuditModel = null;
    emit(FeedbackAuditLoadingState());

    await getAllFeedback();
    await getAllAudit();
  }

  // ========================= DELETE =========================
  deleteFeedbackAudit(int id) {
    emit(DeleteFeedbackAuditLoadingState());
    DioHelper.deleteData(url: 'usage/delete/$id').then((value) {
      final message =
          value?.data['message'] ?? "Operation deleted successfully";
      emit(DeleteFeedbackAuditSuccessState(message!));
    }).catchError((error) {
      emit(DeleteFeedbackAuditErrorState(error.toString()));
    });
  }
}
