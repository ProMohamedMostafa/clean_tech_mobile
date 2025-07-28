import 'package:smart_cleaning_application/features/screens/calendar/data/model/tasks_calendar.dart';

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
  final TasksCalendar tasksCalendar;

  GetAllTasksSuccessState(this.tasksCalendar);
}

class GetAllTasksErrorState extends CalendarState {
  final String error;
  GetAllTasksErrorState(this.error);
}