import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/calendar/data/model/tasks_calendar.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).botNavTitle3,
          style: TextStyle(color: AppColor.primaryColor),
        ),
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          final cubit = context.read<CalendarCubit>();

          if (role == 'Auditor') {
            return const Center(
              child: Text(
                "There's no tasks available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            );
          }

          if (state is GetAllTasksLoadingState) {
            return const Loading();
          } else if (state is GetAllTasksErrorState) {
            return Center(child: Text(state.error));
          } else if (state is GetAllTasksSuccessState) {
            return _buildFullScreenCalendar(
                context, state.tasksCalendar, cubit);
          }

          return Center(child: Text(S.of(context).noTasksAvailable));
        },
      ),
    );
  }

  Widget _buildFullScreenCalendar(
    BuildContext context,
    TasksCalendar tasksCalendar,
    CalendarCubit cubit,
  ) {
    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            view: CalendarView.day,
            dataSource: _getCalendarDataSource(tasksCalendar),
            todayHighlightColor: AppColor.primaryColor,
            showNavigationArrow: true,
            showDatePickerButton: true,
            allowViewNavigation: false,
            showCurrentTimeIndicator: false,
            initialDisplayDate: cubit.selectedDate,
            initialSelectedDate: cubit.selectedDate,
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent),
            ),
            timeSlotViewSettings: TimeSlotViewSettings(
              timeTextStyle: TextStyles.font11BlackMedium,
              allDayPanelColor: Colors.white,
              startHour: 0,
              endHour: 24,
              timeFormat: 'HH:mm',
            ),
            headerHeight: 50.h,
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyles.font16PrimSemiBold,
              backgroundColor: AppColor.fourthColor,
            ),
            appointmentBuilder:
                (BuildContext context, CalendarAppointmentDetails details) {
              final Appointment appointment = details.appointments.first;
              return Container(
                width: details.bounds.width,
                height: details.bounds.height,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: appointment.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        appointment.subject,
                        style: TextStyles.font13WhiteRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        appointment.notes ?? '',
                        style: TextStyles.font9PrimRegular
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.appointment) {
                final Appointment appointment = details.appointments!.first;
                final selectedTask = tasksCalendar.data
                    ?.firstWhere((task) => task.id == appointment.id);
                if (selectedTask != null) {
                  context.pushNamed(
                    Routes.taskDetailsScreen,
                    arguments: selectedTask.id,
                  );
                }
              }
            },
            onViewChanged: (ViewChangedDetails details) {
              final newDate = details.visibleDates.first;
              if (!_isSameDay(newDate, cubit.selectedDate)) {
                cubit.updateSelectedDate(newDate);
              }
            },
          ),
        ),
      ],
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  _AppointmentDataSource _getCalendarDataSource(TasksCalendar tasksCalendar) {
    List<Appointment> appointments = [];

    if (tasksCalendar.data != null) {
      for (var task in tasksCalendar.data!) {
        DateTime date = _parseDateOnly(task.startDate);
        DateTime startTime = _combineDateAndTime(date, task.startTime);
        DateTime endTime = _combineDateAndTime(date, task.endTime);

        if (!endTime.isAfter(startTime)) {
          endTime = startTime.add(const Duration(hours: 1));
        }

        appointments.add(Appointment(
          id: task.id,
          startTime: startTime,
          endTime: endTime,
          subject: task.title ?? '',
          color: _getPriorityColor(task.statusId),
          notes: task.status,
          isAllDay: false,
        ));
      }
    }

    return _AppointmentDataSource(appointments);
  }

  DateTime _combineDateAndTime(DateTime date, String? time) {
    try {
      if (time != null && time.contains(':')) {
        final parts = time.split(':').map(int.parse).toList();
        return DateTime(date.year, date.month, date.day, parts[0], parts[1]);
      }
    } catch (_) {}
    return DateTime(date.year, date.month, date.day);
  }

  DateTime _parseDateOnly(String? dateString) {
    if (dateString == null) return DateTime.now();
    return DateTime.parse(dateString.split('T')[0]);
  }

  Color _getPriorityColor(int? statusId) {
    switch (statusId) {
      case 0:
        return Colors.green; // Pending
      case 1:
        return Color(0xFFDF8412); // In Progress
      case 2:
        return Colors.deepPurple; // Not Approved
      case 3:
        return Color(0xFF01BFFB); // Completed
      case 4:
        return Colors.redAccent; // Rejected
      case 5:
        return Color(0xFF00E296); // Not Resolved
      case 6:
        return const Color.fromARGB(255, 184, 171, 60); // Overdue
      default:
        return Colors.pink; // Default
    }
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
