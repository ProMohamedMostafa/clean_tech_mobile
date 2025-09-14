import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/feedback_answer/data/model/feedback_answer_model.dart';
part 'feedback_answer_state.dart';

class FeedbackAnswerCubit extends Cubit<FeedbackAnswerState> {
  FeedbackAnswerCubit() : super(FeedbackAnswerInitial());

  FeedbackAnswerModel? feedbackAnswerModel;

  List<bool> expandedItems = [];

  Future<void> getAnswerDetails(int id) async {
    emit(FeedbackAnswerLoadingState());
    try {
      final value = await DioHelper.getData(url: "feedback/answers/$id");
      feedbackAnswerModel = FeedbackAnswerModel.fromJson(value!.data);

      final qCount = feedbackAnswerModel?.data?.questions?.length ?? 0;
      expandedItems = List<bool>.filled(qCount, false);

      emit(FeedbackAnswerSuccessState(feedbackAnswerModel!));
    } catch (e) {
      emit(FeedbackAnswerErrorState(e.toString()));
    }
  }

  void toggleExpand(int index) {
    if (index < 0) return;
    if (index >= expandedItems.length) {
      // grow safely if needed
      final newList = List<bool>.from(expandedItems);
      newList.length = index + 1;
      for (int i = expandedItems.length; i < newList.length; i++) {
        newList[i] = false;
      }
      expandedItems = newList;
    }
    expandedItems[index] = !expandedItems[index];
    emit(QuestionToggleSelectAllState());
  }
}
