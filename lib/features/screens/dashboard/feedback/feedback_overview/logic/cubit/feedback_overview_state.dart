part of 'feedback_overview_cubit.dart';

abstract class FeedbackOverviewState {}

final class FeedbackOverviewInitial extends FeedbackOverviewState {}

class SatisfactionRateLoadingState extends FeedbackOverviewState {}

class SatisfactionRateSuccessState extends FeedbackOverviewState {}

class SatisfactionRateErrorState extends FeedbackOverviewState {
  final String error;
  SatisfactionRateErrorState(this.error);
}

//********************************* */
class TotalDeviceLoadingState extends FeedbackOverviewState {}

class TotalDeviceSuccessState extends FeedbackOverviewState {}

class TotalDeviceErrorState extends FeedbackOverviewState {
  final String error;
  TotalDeviceErrorState(this.error);
}

//********************************* */
class TotalQuestionLoadingState extends FeedbackOverviewState {}

class TotalQuestionSuccessState extends FeedbackOverviewState {}

class TotalQuestionErrorState extends FeedbackOverviewState {
  final String error;
  TotalQuestionErrorState(this.error);
}

//********************************* */
class TotalfeedbacksLoadingState extends FeedbackOverviewState {}

class TotalfeedbacksSuccessState extends FeedbackOverviewState {}

class TotalfeedbacksErrorState extends FeedbackOverviewState {
  final String error;
  TotalfeedbacksErrorState(this.error);
}

//********************************* */
class TotalFeedbackLoadingState extends FeedbackOverviewState {}

class TotalFeedbackSuccessState extends FeedbackOverviewState {
  final TotalFeedbackModel totalFeedbackModel;

  TotalFeedbackSuccessState(this.totalFeedbackModel);
}

class TotalFeedbackErrorState extends FeedbackOverviewState {
  final String error;
  TotalFeedbackErrorState(this.error);
}

//********************************* */
class AllFeedbacksLoadingState extends FeedbackOverviewState {}

class AllFeedbacksSuccessState extends FeedbackOverviewState {
  final AllFeedbackModel feedbacksModel;

  AllFeedbacksSuccessState(this.feedbacksModel);
}

class AllFeedbacksErrorState extends FeedbackOverviewState {
  final String error;
  AllFeedbacksErrorState(this.error);
}

//********************************* */
class FeedbackAuditLoadingState extends FeedbackOverviewState {}

class FeedbackAuditSuccessState extends FeedbackOverviewState {
  final FeedbackAuditModel feedbackAuditModel;

  FeedbackAuditSuccessState(this.feedbackAuditModel);
}

class FeedbackAuditErrorState extends FeedbackOverviewState {
  final String error;
  FeedbackAuditErrorState(this.error);
}

//******************************* */

class StatisticsDataLoadingState extends FeedbackOverviewState {}

class StatisticsDataSuccessState extends FeedbackOverviewState {
  final StatisticsModel statisticsModel;

  StatisticsDataSuccessState(this.statisticsModel);
}

class StatisticsDataErrorState extends FeedbackOverviewState {
  final String error;
  StatisticsDataErrorState(this.error);
}

//******************************* */

final class FilterDialogLoading<T> extends FeedbackOverviewState {}

final class FilterDialogSuccess<T> extends FeedbackOverviewState {}

final class FilterDialogError<T> extends FeedbackOverviewState {}

//**************** */
class FilterDialogLevelChanged extends FeedbackOverviewState {}

class OverviewLocationChanged extends FeedbackOverviewState {}

class OverviewDateChanged extends FeedbackOverviewState {}

class ChangeChartTypeFeedbackState extends FeedbackOverviewState {}

class ChangeFeedbackState extends FeedbackOverviewState {}

class FilterDialogCleared extends FeedbackOverviewState {}
