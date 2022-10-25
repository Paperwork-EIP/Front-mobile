import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Calendar")),
        body: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 20),
          lastDay: DateTime.utc(2040, 10, 20),
          focusedDay: _focusedDay,
          headerVisible: true,
          sixWeekMonthsEnforced: true,
          shouldFillViewport: false,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w800)),
          calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ));
  }
}
