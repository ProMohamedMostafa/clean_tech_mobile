import 'package:smart_cleaning_application/features/screens/dashboard/activity/data/model/activities_model.dart';

abstract class ActivityState {}

class ActivityInitialState extends ActivityState {}

class ActivityLoadingState extends ActivityState {}

class ActivitySuccessState extends ActivityState {
  final ActivitiesModel activitiesModel;

  ActivitySuccessState(this.activitiesModel);
}

class ActivityErrorState extends ActivityState {
  final String error;
  ActivityErrorState(this.error);
}
