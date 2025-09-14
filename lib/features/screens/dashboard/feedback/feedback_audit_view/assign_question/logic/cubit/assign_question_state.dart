part of 'assign_question_cubit.dart';

abstract class AssignQuestionState {}

final class AssignQuestionInitial extends AssignQuestionState {}
//***************************** */
final class QuestionLoadingState extends AssignQuestionState {}

final class QuestionSuccessState extends AssignQuestionState {}

final class QuestionErrorState extends AssignQuestionState {
  final String error;

  QuestionErrorState(this.error);
}
//***************** */

class AssignQuestionLoadingState extends AssignQuestionState {}

class AssignQuestionSuccessState extends AssignQuestionState {
  final String message;

  AssignQuestionSuccessState(this.message);
}

class AssignQuestionErrorState extends AssignQuestionState {
  final String error;
  AssignQuestionErrorState(this.error);
}
//****************************** */
class QuestionToggleSelectAllState extends AssignQuestionState {}