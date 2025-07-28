import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/calendar/data/model/tasks_calendar.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitialState());

  TasksCalendar? tasksCalendar;
  DateTime selectedDate = DateTime.now();

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasks(startDate: newDate);
  }

  getAllTasks({DateTime? startDate}) {
    final date = startDate ?? selectedDate;
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/calendar", query: {
      'StartDate': DateFormat('yyyy-MM-dd', 'en').format(date),
    }).then((value) {
      tasksCalendar = TasksCalendar.fromJson(value!.data);
      emit(GetAllTasksSuccessState(tasksCalendar!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }
}
