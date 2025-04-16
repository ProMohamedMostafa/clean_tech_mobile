import 'package:smart_cleaning_application/features/screens/notification/data/model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final NotificationModel notificationModel;

  NotificationSuccessState(this.notificationModel);
}

class NotificationErrorState extends NotificationState {
  final String error;
  NotificationErrorState(this.error);
}

//************ */

class UnReadNotificationLoadingState extends NotificationState {}

class UnReadNotificationSuccessState extends NotificationState {
  final NotificationModel unReadnotificationModel;

  UnReadNotificationSuccessState(this.unReadnotificationModel);
}

class UnReadNotificationErrorState extends NotificationState {
  final String error;
  UnReadNotificationErrorState(this.error);
}
//************** */
class MarkReadLoadingState extends NotificationState {}

class MarkReadSuccessState extends NotificationState { final String message;

  MarkReadSuccessState(this.message);}

class MarkReadErrorState extends NotificationState {
  final String error;
  MarkReadErrorState(this.error);
}

//************ */
class ChangeIconVisiabiltyState extends NotificationState {}
