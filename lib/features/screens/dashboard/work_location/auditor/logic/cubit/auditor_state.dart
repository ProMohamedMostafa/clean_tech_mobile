part of 'auditor_cubit.dart';

abstract class AuditorState {}

final class AuditorInitial extends AuditorState {}

final class AuditLocationLoadingState extends AuditorState {}

final class AuditLocationSuccessState extends AuditorState {
  final AuditLocationModel auditLocationModel;

  AuditLocationSuccessState(this.auditLocationModel);
}

final class AuditLocationErrorState extends AuditorState {
  final String error;

  AuditLocationErrorState(this.error);
}

//************************* */
final class AuditLocationDetailsLoadingState extends AuditorState {}

final class AuditLocationDetailsSuccessState extends AuditorState {
  final AuditLocationDetailsModel auditLocationDetailsModel;

  AuditLocationDetailsSuccessState(this.auditLocationDetailsModel);
}

final class AuditLocationDetailsErrorState extends AuditorState {
  final String error;

  AuditLocationDetailsErrorState(this.error);
}

//************************* */
final class AuditorHistoryLoadingState extends AuditorState {}

final class AuditorHistorySuccessState extends AuditorState {
  final AuditorHistoryModel auditorHistoryModel;

  AuditorHistorySuccessState(this.auditorHistoryModel);
}

final class AuditorHistoryErrorState extends AuditorState {
  final String error;

  AuditorHistoryErrorState(this.error);
}

//************************* */
final class AuditorQuestionsLoadingState extends AuditorState {}

final class AuditorQuestionsSuccessState extends AuditorState {
  final AllQuestionsModel auditorQuestionsModel;

  AuditorQuestionsSuccessState(this.auditorQuestionsModel);
}

final class AuditorQuestionsErrorState extends AuditorState {
  final String error;

  AuditorQuestionsErrorState(this.error);
}
//***************************** */

final class AddAuditorAnswerLoadingState extends AuditorState {}

final class AddAuditorAnswerSuccessState extends AuditorState {
  final String message;

  AddAuditorAnswerSuccessState(this.message);
}

final class AddAuditorAnswerErrorState extends AuditorState {
  final String error;

  AddAuditorAnswerErrorState(this.error);
}

//************************* */

class DescToggleState extends AuditorState {}
class QuestionToggleSelectAllState extends AuditorState {}
class AuditorUpdateState extends AuditorState {}
class AuditorAnswerUpdated extends AuditorState {}