part of 'add_question_cubit.dart';

abstract class AddQuestionState {}

final class AddQuestionInitial extends AddQuestionState {}

final class AddQuestionLoadingState extends AddQuestionState {}

final class AddQuestionSuccessState extends AddQuestionState {
  final String message;
  AddQuestionSuccessState(this.message);
}

final class AddQuestionErrorState extends AddQuestionState {
  final String error;
  AddQuestionErrorState(this.error);
}

//*********************** */
final class SelectedTabChangedState extends AddQuestionState {
  final int index;
  SelectedTabChangedState(this.index);
}

final class ChoicesUpdatedState extends AddQuestionState {}

final class RatingTypeChangedState extends AddQuestionState {
  final int selectedType;
  RatingTypeChangedState(this.selectedType);
}
