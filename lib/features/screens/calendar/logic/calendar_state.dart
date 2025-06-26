import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';

abstract class CalendarState {}

class CalendarInitialState extends CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarSuccessState extends CalendarState {}

class CalendarErrorState extends CalendarState {
  final String error;
  CalendarErrorState(this.error);
}
//**************************************** */

class GetAllTasksLoadingState extends CalendarState {}

class GetAllTasksSuccessState extends CalendarState {
  final AllTasksModel allTasksModel;

  GetAllTasksSuccessState(this.allTasksModel);
}

class GetAllTasksErrorState extends CalendarState {
  final String error;
  GetAllTasksErrorState(this.error);
}