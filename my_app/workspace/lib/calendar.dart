import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/global.dart' as globals;

class Event {
  final DateTime date;
  final int userProcessId;
  final String processTitle;
  final int stepId;
  final String stepTitle;
  final String stepDescription;

  Event(
      {required this.date,
      required this.userProcessId,
      required this.processTitle,
      required this.stepId,
      required this.stepTitle,
      required this.stepDescription});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      date: DateTime.parse(json['date']),
      userProcessId: json['user_process_id'],
      processTitle: json['process_title'],
      stepId: json['step_id'],
      stepTitle: json['step_title'],
      stepDescription: json['step_description'],
    );
  }
  dynamic toJson() => {
        'date': date,
        'user_process_id': userProcessId,
        'process_title': processTitle,
        'step_id': stepId,
        'step_title': stepTitle,
        'step_description': stepDescription
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

late Map<DateTime, List<Event>> kEventsSource = {};

Future<List<Event>> fetchEvents() async {
  List<Event> events = [];
  final email = globals.email;

  final response = await http.get(
    Uri.parse("${dotenv.get('SERVER_URL')}/calendar/getAll?email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    var appointments = jsonDecode(response.body)['appoinment'];

    for (var app in appointments) {
      events.add(Event.fromJson(app));
    }

    for (var event in events) {
      if (kEventsSource.containsKey(event.date)) {
        print("already in there");
      } else {
        late List<Event> eventList = <Event>[event];
        //TODO rewrite time for DateTime key using event.date + Time 00:00:00
        var elem = <DateTime, List<Event>>{event.date: eventList};
        kEventsSource.addEntries(elem.entries);
      }
    }

    return events;
  } else {
    throw Exception("Failed to fetch calendar events");
  }
}

late LinkedHashMap<DateTime, List<Event>> kEvents;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
    kEvents = LinkedHashMap<DateTime, List<Event>>()..addAll(kEventsSource);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    print("events : \n");
    print(kEvents);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    print("day : " +
        day.toString() +
        "\ninfo : " +
        kEvents[day].toString() +
        "\n");
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calendar"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline_sharp),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(children: [
          TableCalendar<Event>(
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
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]));
  }
}
