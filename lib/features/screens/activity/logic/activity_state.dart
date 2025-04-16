import 'package:smart_cleaning_application/features/screens/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';

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
//**************************** */

class RoleLoadingState extends ActivityState {}

class RoleSuccessState extends ActivityState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends ActivityState {
  final String error;
  RoleErrorState(this.error);
}