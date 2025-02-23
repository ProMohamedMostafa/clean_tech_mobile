import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.week,
          specialRegions: _getTimeRegions(),
        ),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        enablePointerInteraction: false,
        color: Colors.grey.withOpacity(0.2),
        text: 'Task'));

    return regions;
  }
}
