part of 'assign_question_cubit.dart';

abstract class AssignQuestionPointState {}

final class AssignQuestionPointInitial extends AssignQuestionPointState {}

//***************************** */
final class QuestionLoadingState extends AssignQuestionPointState {}

final class QuestionSuccessState extends AssignQuestionPointState {}

final class QuestionErrorState extends AssignQuestionPointState {
  final String error;

  QuestionErrorState(this.error);
}
//***************** */

class AssignQuestionPointLoadingState extends AssignQuestionPointState {}

class AssignQuestionPointSuccessState extends AssignQuestionPointState {
  final String message;

  AssignQuestionPointSuccessState(this.message);
}

class AssignQuestionPointErrorState extends AssignQuestionPointState {
  final String error;
  AssignQuestionPointErrorState(this.error);
}

//****************************** */
class QuestionToggleSelectAllState extends AssignQuestionPointState {}
