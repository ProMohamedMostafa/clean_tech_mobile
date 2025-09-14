part of 'feedback_answer_cubit.dart';

abstract class FeedbackAnswerState {}

final class FeedbackAnswerInitial extends FeedbackAnswerState {}

final class FeedbackAnswerLoadingState extends FeedbackAnswerState {}

final class FeedbackAnswerSuccessState extends FeedbackAnswerState {
  final FeedbackAnswerModel feedbackAnswerModel;

  FeedbackAnswerSuccessState(this.feedbackAnswerModel);
}

final class FeedbackAnswerErrorState extends FeedbackAnswerState {
  final String error;

  FeedbackAnswerErrorState(this.error);
}

//************ */

final class QuestionToggleSelectAllState extends FeedbackAnswerState {}
