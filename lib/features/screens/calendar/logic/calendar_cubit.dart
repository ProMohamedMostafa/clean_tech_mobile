import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_state.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitialState());

  static CalendarCubit get(context) => BlocProvider.of(context);

// Start of the week (Saturday)
  final startOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday % 7));

  AllTasksModel? allTasksModel;
  getAllTasks({DateTime? startDate, DateTime? endDate}) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'StartDate': DateFormat('yyyy-MM-dd').format(startDate ?? startOfWeek),
      'EndDate': DateFormat('yyyy-MM-dd')
          .format(endDate ?? startOfWeek.add(const Duration(days: 6))),
    }).then((value) {
      allTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }
}
