import 'package:smart_cleaning_application/features/screens/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/attendance_status.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/attendance_status_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/completetion_task.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/material_count_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/shifts_count_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/stock_total_price_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_status_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/total_stock.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/users_count_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/notification/data/model/notification_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

//******************************* */

class UserDetailsLoadingState extends HomeState {}

class UserDetailsSuccessState extends HomeState {
  final ProfileModel profileModel;

  UserDetailsSuccessState(this.profileModel);
}

class UserDetailsErrorState extends HomeState {
  final String error;
  UserDetailsErrorState(this.error);
}

//******************************* */

class ClockInOutLoadingState extends HomeState {}

class ClockInOutSuccessState extends HomeState {
  final String message;

  ClockInOutSuccessState(this.message);
}

class ClockInOutErrorState extends HomeState {
  final String error;
  ClockInOutErrorState(this.error);
}
//********************************* */

class UserStatusLoadingState extends HomeState {}

class UserStatusSuccessState extends HomeState {
  final AttendanceStatusModel attendanceStatusModel;

  UserStatusSuccessState(this.attendanceStatusModel);
}

class UserStatusErrorState extends HomeState {
  final String error;
  UserStatusErrorState(this.error);
}
//******************************** */

class ActivityLoadingState extends HomeState {}

class ActivitySuccessState extends HomeState {
  final ActivitiesModel activitiesModel;

  ActivitySuccessState(this.activitiesModel);
}

class ActivityErrorState extends HomeState {
  final String error;
  ActivityErrorState(this.error);
}
//********************************* */

class TotalStockLoadingState extends HomeState {}

class TotalStockSuccessState extends HomeState {
  final TotalStockModel totalStockModel;

  TotalStockSuccessState(this.totalStockModel);
}

class TotalStockErrorState extends HomeState {
  final String error;
  TotalStockErrorState(this.error);
}
//********************************* */

class CompletetionTaskLoadingState extends HomeState {}

class CompletetionTaskSuccessState extends HomeState {
  final CompletetionTaskModel completetionTaskModel;

  CompletetionTaskSuccessState(this.completetionTaskModel);
}

class CompletetionTaskErrorState extends HomeState {
  final String error;
  CompletetionTaskErrorState(this.error);
}
//********************************* */

class TaskStatusLoadingState extends HomeState {}

class TaskStatusSuccessState extends HomeState {
  final TaskStatusModel taskStatusModel;

  TaskStatusSuccessState(this.taskStatusModel);
}

class TaskStatusErrorState extends HomeState {
  final String error;
  TaskStatusErrorState(this.error);
}
//**************************** */

class AllProvidersLoadingState extends HomeState {}

class AllProvidersSuccessState extends HomeState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends HomeState {
  final String error;
  AllProvidersErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends HomeState {}

class AllUsersSuccessState extends HomeState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends HomeState {
  final String error;
  AllUsersErrorState(this.error);
}
//********************************* */

class MaterialCountLoadingState extends HomeState {}

class MaterialCountSuccessState extends HomeState {
  final MaterialCountModel materialCountModel;

  MaterialCountSuccessState(this.materialCountModel);
}

class MaterialCountErrorState extends HomeState {
  final String error;
  MaterialCountErrorState(this.error);
}

//********************************* */

class StockTotalPriceLoadingState extends HomeState {}

class StockTotalPriceSuccessState extends HomeState {
  final StockTotalPriceModel stockTotalPriceModel;

  StockTotalPriceSuccessState(this.stockTotalPriceModel);
}

class StockTotalPriceErrorState extends HomeState {
  final String error;
  StockTotalPriceErrorState(this.error);
}
//********************************* */

class AttendanceStatusLoadingState extends HomeState {}

class AttendanceStatusSuccessState extends HomeState {
  final AttendanceStatus attendanceStatusModel;

  AttendanceStatusSuccessState(this.attendanceStatusModel);
}

class AttendanceStatusErrorState extends HomeState {
  final String error;
  AttendanceStatusErrorState(this.error);
}

//********************************* */

class UsersCountLoadingState extends HomeState {}

class UsersCountSuccessState extends HomeState {
  final UsersCountModel usersCountModelModel;

  UsersCountSuccessState(this.usersCountModelModel);
}

class UsersCountErrorState extends HomeState {
  final String error;
  UsersCountErrorState(this.error);
}
//********************************* */

class ShiftsCountLoadingState extends HomeState {}

class ShiftsCountSuccessState extends HomeState {
  final ShiftsCountModel shiftsCountModelModel;

  ShiftsCountSuccessState(this.shiftsCountModelModel);
}

class ShiftsCountErrorState extends HomeState {
  final String error;
  ShiftsCountErrorState(this.error);
}

//************************** */
//************ */

class UnReadNotificationLoadingState extends HomeState {}

class UnReadNotificationSuccessState extends HomeState {
  final NotificationModel unReadnotificationModel;

  UnReadNotificationSuccessState(this.unReadnotificationModel);
}

class UnReadNotificationErrorState extends HomeState {
  final String error;
  UnReadNotificationErrorState(this.error);
}

//************ */
class ChangeChartTypeStockState extends HomeState {}

class ChangeChartTypeCompleteTaskState extends HomeState {}

class ChangeChartTypeTaskState extends HomeState {}

class ChangeProviderState extends HomeState {}

class ChangeUserState extends HomeState {}

class ChangeUserTaskState extends HomeState {}

class ChangeVisiabiltyState extends HomeState {}
class ChangeVisiabiltyListState extends HomeState {}

