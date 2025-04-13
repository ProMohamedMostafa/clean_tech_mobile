import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_state.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    context.read<CalendarCubit>().getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (state is GetAllTasksLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ));
          } else if (state is GetAllTasksErrorState) {
            return Center(child: Text(state.error));
          } else if (state is GetAllTasksSuccessState) {
            return _buildFullScreenCalendar(state.allTasksModel);
          }
          return const Center(child: Text('No tasks available'));
        },
      ),
    );
  }

  Widget _buildFullScreenCalendar(AllTasksModel allTasksModel) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: _getCalendarDataSource(allTasksModel),
              todayHighlightColor: AppColor.primaryColor,
              showNavigationArrow: true,
              showDatePickerButton: true,
              allowViewNavigation: false,
              showCurrentTimeIndicator: false,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: true,
                agendaViewHeight: 200,
                agendaItemHeight: 60,
                numberOfWeeksInView: 6,
              ),
              headerHeight: 50.h,
              headerStyle: CalendarHeaderStyle(
                backgroundColor: Colors.white,
                textAlign: TextAlign.center,
                textStyle: TextStyles.font16PrimSemiBold,
              ),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.appointment) {
                  final Appointment appointment = details.appointments!.first;

                  TaskData? selectedTask = allTasksModel.data?.data
                      ?.firstWhere((task) => task.id == appointment.id);

                  if (selectedTask != null) {
                    Navigator.pushNamed(
                      context,
                      Routes.taskDetailsScreen,
                      arguments: selectedTask.id,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _AppointmentDataSource _getCalendarDataSource(AllTasksModel allTasksModel) {
    List<Appointment> appointments = [];

    if (allTasksModel.data?.data != null) {
      for (var task in allTasksModel.data!.data!) {
        DateTime startDate = _parseDateOnly(task.startDate);
        DateTime endDate = _parseDateOnly(task.endDate);

        // Ensure end date is not before start date
        if (endDate.isBefore(startDate)) {
          endDate = startDate.add(const Duration(days: 1));
        }

        appointments.add(Appointment(
          id: task.id,
          startTime: startDate,
          endTime: endDate,
          subject: '${task.title}\n${task.pointName ?? ''}',
          color: _getPriorityColor(task.priorityId),
          notes: task.description,
          isAllDay: true,
        ));
      }
    }

    return _AppointmentDataSource(appointments);
  }

  DateTime _parseDateOnly(String? dateString) {
    if (dateString == null) return DateTime.now();
    return DateTime.parse(dateString.split('T')[0]);
  }

  Color _getPriorityColor(int? priorityId) {
    switch (priorityId) {
      case 1:
        return Colors.cyan;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.lightGreen;
      default:
        return Colors.blueAccent;
    }
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
