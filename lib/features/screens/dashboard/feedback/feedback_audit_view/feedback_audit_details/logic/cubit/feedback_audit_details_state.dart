part of 'feedback_audit_details_cubit.dart';

abstract class FeedbackAuditDetailsState {}

final class FeedbackAuditDetailsInitial extends FeedbackAuditDetailsState {}

final class FeedbackAuditDetailsLoadingState
    extends FeedbackAuditDetailsState {}

final class FeedbackAuditDetailsSuccessState
    extends FeedbackAuditDetailsState {
  final FeedbackAuditDetailsModel feedbackAuditDetailsModel;
  FeedbackAuditDetailsSuccessState(this.feedbackAuditDetailsModel);
}

final class FeedbackAuditDetailsErrorState extends FeedbackAuditDetailsState {
  final String error;
  FeedbackAuditDetailsErrorState(this.error);
}
//***************************** */
final class QuestionLoadingState extends FeedbackAuditDetailsState {}

final class QuestionSuccessState extends FeedbackAuditDetailsState {}

final class QuestionErrorState extends FeedbackAuditDetailsState {
  final String error;

  QuestionErrorState(this.error);
}

//****************************** */
class QuestionToggleSelectAllState extends FeedbackAuditDetailsState {}