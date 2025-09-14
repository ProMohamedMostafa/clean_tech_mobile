part of 'question_cubit.dart';

abstract class QuestionState {}

final class QuestionInitialState extends QuestionState {}

final class QuestionLoadingState extends QuestionState {}

final class QuestionSuccessState extends QuestionState {}

final class QuestionErrorState extends QuestionState {
  final String error;

  QuestionErrorState(this.error);
}
//***************** */

class DeleteQuestionLoadingState extends QuestionState {}

class DeleteQuestionSuccessState extends QuestionState {
  final String message;

  DeleteQuestionSuccessState(this.message);
}

class DeleteQuestionErrorState extends QuestionState {
  final String error;
  DeleteQuestionErrorState(this.error);
}
//***************** */

class AssignQuestionLoadingState extends QuestionState {}

class AssignQuestionSuccessState extends QuestionState {
  final String message;

  AssignQuestionSuccessState(this.message);
}

class AssignQuestionErrorState extends QuestionState {
  final String error;
  AssignQuestionErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends QuestionState {}

class GetSectionSuccessState extends QuestionState {
  final SectionBasicModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends QuestionState {
  final String error;
  GetSectionErrorState(this.error);
}
//****************************** */

class QuestionToggleSelectAllState extends QuestionState {}

class QuestionToggleItemState extends QuestionState {}

class QuestionFlagState extends QuestionState {}
