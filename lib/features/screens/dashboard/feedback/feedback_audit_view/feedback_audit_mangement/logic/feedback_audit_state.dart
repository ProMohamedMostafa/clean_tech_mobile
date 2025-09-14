part of 'feedback_audit_cubit.dart';

abstract class FeedbackAuditState {}

final class FeedbackAuditInitialState extends FeedbackAuditState {}

final class FeedbackAuditLoadingState extends FeedbackAuditState {}

final class FeedbackAuditSuccessState extends FeedbackAuditState {
  final dynamic data; 
  FeedbackAuditSuccessState(this.data);
}


final class FeedbackAuditErrorState extends FeedbackAuditState {
  final String error;

  FeedbackAuditErrorState(this.error);
}
//***************** */

class DeleteFeedbackAuditLoadingState extends FeedbackAuditState {}

class DeleteFeedbackAuditSuccessState extends FeedbackAuditState {
  final String message;

  DeleteFeedbackAuditSuccessState(this.message);
}

class DeleteFeedbackAuditErrorState extends FeedbackAuditState {
  final String error;
  DeleteFeedbackAuditErrorState(this.error);
}
