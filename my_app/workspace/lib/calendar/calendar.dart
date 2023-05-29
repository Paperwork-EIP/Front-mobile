import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paperwork/calendar/calendar_form_add.dart';
import 'package:paperwork/calendar/calendar_form_update.dart';
import 'package:paperwork/global.dart' as globals;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:table_calendar/table_calendar.dart';

class UserProcess {
  final int? progress;
  final int id;
  final int processId;
  final String title;
  final String description;
  final Uri source;
  final String stockedTitle;
  final bool isCompleted;

  UserProcess({
    required this.progress,
    required this.id,
    required this.processId,
    required this.title,
    required this.description,
    required this.source,
    required this.stockedTitle,
    required this.isCompleted,
  });

  factory UserProcess.fromJson(Map<String, dynamic> json) {
    return UserProcess(
      progress: json['pourcentage'] ?? 0,
      id: json['userProcess']['id'],
      processId: json['userProcess']['process_id'],
      title: json['userProcess']['title'],
      description: json['userProcess']['description'],
      source: Uri.parse(json['userProcess']['source']),
      stockedTitle: json['userProcess']['stocked_title'],
      isCompleted: json['userProcess']['is_done'] == true,
    );
  }
}

class UserProcessStep {
  final int stepId;
  final String title;
  final String description;
  final String type;
  final Uri source;
  final bool isCompleted;
  final int processId;

  UserProcessStep({
    required this.stepId,
    required this.title,
    required this.description,
    required this.type,
    required this.source,
    required this.isCompleted,
    required this.processId,
  });

  factory UserProcessStep.fromJson(Map<String, dynamic> json, int processId) =>
      UserProcessStep(
        stepId: json['step_id'],
        title: json['title'],
        description: json['description'],
        type: json['type'],
        source: Uri.parse(json['source']),
        isCompleted: json['is_done'] == true,
        processId: processId,
      );
}

class Event {
  final DateTime date;
  final int userProcessId;
  final String processTitle;
  final int stepId;
  final String stepTitle;
  final String stepDescription;

  Event({
    required this.date,
    required this.userProcessId,
    required this.processTitle,
    required this.stepId,
    required this.stepTitle,
    required this.stepDescription,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        date: DateTime.parse(json['date']),
        userProcessId: json['user_process_id'],
        processTitle: json['process_title'],
        stepId: json['step_id'],
        stepTitle: json['step_title'],
        stepDescription: json['step_description'],
      );
}

class UserProcessData {
  final List<UserProcess> userProcess;
  final List<UserProcessStep> userProcessStep;
  final List<Event> event;

  UserProcessData({
    required this.userProcess,
    required this.userProcessStep,
    required this.event,
  });
}

Future<List<UserProcess>> getUserProcesses() async {
  final String serverUrl = dotenv.get('SERVER_URL');
  final String token = globals.token;
  final Uri url =
      Uri.parse('$serverUrl/userProcess/getUserProcesses?user_token=$token');
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final http.Response response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    return Future.value(
      List<UserProcess>.from(json
          .decode(response.body)['response']
          .map((e) => UserProcess.fromJson(e))),
    );
  } else {
    throw Exception('Failed to fetch User Processes');
  }
}

Future<List<UserProcessStep>> getUserProcessesSteps(
    List<int> userProcessIds) async {
  final String serverUrl = dotenv.get('SERVER_URL');
  final Map<String, String> headers = {"Content-Type": "application/json"};
  List<UserProcessStep> userProcessSteps = [];

  for (final int it in userProcessIds) {
    final Uri url = Uri.parse(
        '$serverUrl/userProcess/getUserStepsById?user_process_id=$it');
    final http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      userProcessSteps = List<UserProcessStep>.from(json
          .decode(response.body)['response']
          .map((e) => UserProcessStep.fromJson(e, it)));
    } else {
      throw Exception('Failed to fetch User Processes Steps');
    }
  }
  return Future.value(userProcessSteps);
}

Future<List<Event>> getCalendarEvent() async {
  final String serverUrl = dotenv.get('SERVER_URL');
  final String token = globals.token;
  final Uri url = Uri.parse('$serverUrl/calendar/getAll?token=$token');
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final http.Response response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    return Future.value(
      List<Event>.from(json
          .decode(response.body)['appoinment']
          .map((e) => Event.fromJson(e))),
    );
  } else {
    throw Exception('Failed to fetch Calendar Events');
  }
}

Future<UserProcessData> getUserProcessesData() async {
  final List<UserProcess> userProcess = await getUserProcesses();
  final List<UserProcessStep> userProcessStep =
      await getUserProcessesSteps(userProcess.map((e) => e.id).toList());
  final List<Event> event = await getCalendarEvent();

  return UserProcessData(
    userProcess: userProcess,
    userProcessStep: userProcessStep,
    event: event,
  );
}

class EventCard extends StatefulWidget {
  final Event event;
  final UserProcessData userProcessData;

  const EventCard(
      {super.key, required this.event, required this.userProcessData});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isCompleted = false;

  @override
  void initState() {
    isCompleted = widget.userProcessData.userProcessStep
        .firstWhere((element) => element.stepId == widget.event.stepId)
        .isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CalendarFormUpdate(
                dateTime: widget.event.date,
                processId: widget.event.userProcessId,
                stepId: widget.event.stepId,
                userProcessData: widget.userProcessData,
              ))),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.event.date.toString().substring(11, 16),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isCompleted) ...[const Icon(Icons.done)],
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.event.processTitle,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              Text(widget.event.stepTitle,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Future<UserProcessData> _userProcessData;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Event> _eventsOfSelectedDay = [];

  @override
  void initState() {
    _userProcessData = getUserProcessesData();
    super.initState();
  }

  List<Event> _getEventsOfSelectedDay(
      DateTime selectedDay, UserProcessData userProcessData) {
    return userProcessData.event
        .where(
          (element) =>
              element.date.day == selectedDay.day &&
              element.date.month == selectedDay.month &&
              element.date.year == element.date.year,
        )
        .toList();
  }

  bool _selectedDayPredicate(DateTime day) => isSameDay(_selectedDay, day);

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay,
          UserProcessData userProcessData) =>
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _eventsOfSelectedDay =
            _getEventsOfSelectedDay(selectedDay, userProcessData);
      });

  List<Event> _eventLoader(DateTime day, UserProcessData userProcessData) {
    return userProcessData.event
        .where(
          (element) =>
              element.date.day == day.day &&
              element.date.month == day.month &&
              element.date.year == element.date.year,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProcessData>(
      future: _userProcessData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_selectedDay.toString().substring(0, 10) ==
              DateTime.now().toString().substring(0, 10)) {
            _eventsOfSelectedDay =
                _getEventsOfSelectedDay(_selectedDay, snapshot.data!);
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 96, 128, 118),
              title: const Text('Calendar'),
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => CalendarFormAdd(
                                  userProcessData: snapshot.data!)),
                        ),
                    icon: const Icon(Icons.add))
              ],
            ),
            body: Center(
                child: Column(
              children: [
                TableCalendar(
                  headerStyle: const HeaderStyle(formatButtonVisible: false),
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(1970, 01, 01),
                  lastDay: DateTime.utc(2070, 01, 01),
                  selectedDayPredicate: _selectedDayPredicate,
                  onDaySelected: (selectedDay, focusedDay) =>
                      _onDaySelected(selectedDay, focusedDay, snapshot.data!),
                  eventLoader: (day) => _eventLoader(day, snapshot.data!),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24.0),
                    itemCount: _eventsOfSelectedDay.length,
                    itemBuilder: (BuildContext context, int index) => EventCard(
                      event: _eventsOfSelectedDay[index],
                      userProcessData: snapshot.data!,
                    ),
                  ),
                )
              ],
            )),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 96, 128, 118),
              title: const Text('Calendar'),
            ),
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
