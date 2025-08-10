import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/data/model/notification_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeLocaleState extends AppStates {
  final Locale locale;
  ChangeLocaleState({required this.locale});
}//************************** */

class UnReadNotificationLoadingState extends AppStates {}

class UnReadNotificationSuccessState extends AppStates {
  final NotificationModel unReadnotificationModel;

  UnReadNotificationSuccessState(this.unReadnotificationModel);
}

class UnReadNotificationErrorState extends AppStates {
  final String error;
  UnReadNotificationErrorState(this.error);
}
//**************************************** */

class NotificationCountUpdatedState extends AppStates {}

class ChangeCarouselIndexState extends AppStates {}
