part of 'edit_question_cubit.dart';

abstract class EditQuestionState {}

final class EditQuestionInitial extends EditQuestionState {}

final class EditQuestionLoadingState extends EditQuestionState {}

final class EditQuestionSuccessState extends EditQuestionState {
  final String message;
  EditQuestionSuccessState(this.message);
}

final class EditQuestionErrorState extends EditQuestionState {
  final String error;
  EditQuestionErrorState(this.error);
}

//************************ */
final class QuestionDetailsLoadingState extends EditQuestionState {}

final class QuestionDetailsSuccessState extends EditQuestionState {
  final QuestionDetailsModel questionDetailsModel;
  QuestionDetailsSuccessState(this.questionDetailsModel);
}

final class QuestionDetailsErrorState extends EditQuestionState {
  final String error;
  QuestionDetailsErrorState(this.error);
}
//*************************** */
final class SelectedTabChangedState extends EditQuestionState {
  final int index;
  SelectedTabChangedState(this.index);
}

final class ChoicesUpdatedState extends EditQuestionState {}

final class RatingTypeChangedState extends EditQuestionState {
  final int selectedType;
  RatingTypeChangedState(this.selectedType);
}

class FilesSelectedState extends EditQuestionState {
  final List<PlatformFile> files;
  FilesSelectedState(this.files);
}
