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
      date: DateTime.parse(json['date']).toUtc(),
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
        var date =
            DateTime.utc(event.date.year, event.date.month, event.date.day);
        print("DATE" + date.toString());
        var elem = <DateTime, List<Event>>{date: eventList};
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
  DateTime _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toUtc();
  DateTime? _selectedDay;
  late ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  late Future<List<Event>> futureEvents;

//add event
  late TextEditingController _processController =
      TextEditingController(text: "process name");
  late TextEditingController _stepController =
      TextEditingController(text: "step name");
  late TextEditingController _descriptionController =
      TextEditingController(text: "description of the process");
  late TextEditingController _hourController =
      TextEditingController(text: "10");
  late TextEditingController _minuteController =
      TextEditingController(text: "00");

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
    kEvents = LinkedHashMap<DateTime, List<Event>>()..addAll(kEventsSource);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//    print("selEvents : " + _selectedEvents.value.toString());

//    print(_selectedDay.toString());
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
// empty kEvents somehow
    _processController.dispose();
    _stepController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
//    print(kEvents.containsKey(day));
//    print(kEvents[DateTime(2023, 01, 26)]);
//    print(DateTime(2023, 01, 26));
    // if (kEvents.containsKey(day) == false) {
    //   return kEvents[day] ?? [];
    // }
//    print("day : " + day.toString() + "\nevents : " + kEvents[day].toString());
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDay = selectedDay.toUtc();
    focusedDay = focusedDay.toUtc();
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
      print("_selectedEvents - selectedDay : ");
      print(_selectedEvents.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("select : " + _selectedDay.toString());
    print(kEvents[_selectedDay]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF29C9B3),
          title: const Text("Calendar"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline_sharp),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController _processController =
                        TextEditingController(text: "process name");
                    TextEditingController _stepController =
                        TextEditingController(text: "step name");
                    TextEditingController _descriptionController =
                        TextEditingController(
                            text: "description of the process");
                    TextEditingController _hourController =
                        TextEditingController(text: "10");
                    TextEditingController _minuteController =
                        TextEditingController(text: "00");
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("Add Event"),
                      content: Column(
                        children: [
                          TextFormField(
                            controller: _processController,
                          ),
                          TextFormField(
                            controller: _stepController,
                          ),
                          TextFormField(
                            controller: _descriptionController,
                          ),
                          TextFormField(
                            controller: _hourController,
                          ),
                          TextFormField(
                            controller: _minuteController,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () {
                            if (_processController.text.isEmpty ||
                                _descriptionController.text.isEmpty ||
                                _hourController.text.isEmpty ||
                                _minuteController.text.isEmpty ||
                                _stepController.text.isEmpty) {
                              print("EMPTY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                            } else {
                              if (_selectedDay != null) {
                                if (kEvents[_selectedDay!] != null) {
                                  kEvents[_selectedDay]?.add(
                                    Event(
                                        processTitle: _processController.text,
                                        date: DateTime.utc(
                                            _selectedDay!.year,
                                            _selectedDay!.month,
                                            _selectedDay!.day,
                                            int.parse(_hourController.text),
                                            int.parse(_minuteController.text)),
                                        stepDescription:
                                            _descriptionController.text,
                                        stepId: 5,
                                        stepTitle: _stepController.text,
                                        userProcessId: 5),
                                  );
                                } else {
                                  print("objectAAAAAAAA");
                                  late List<Event> eventList = <Event>[
                                    Event(
                                        processTitle: _processController.text,
                                        date: DateTime.utc(
                                            _selectedDay!.year,
                                            _selectedDay!.month,
                                            _selectedDay!.day,
                                            int.parse(_hourController.text),
                                            int.parse(_minuteController.text)),
                                        stepDescription:
                                            _descriptionController.text,
                                        stepId: 5,
                                        stepTitle: _stepController.text,
                                        userProcessId: 5),
                                  ];
                                  var date = DateTime.utc(
                                      _selectedDay!.year,
                                      _selectedDay!.month,
                                      _selectedDay!.day,
                                      int.parse(_hourController.text),
                                      int.parse(_minuteController.text));
                                  print("DATE" + date.toString());
                                  var elem = <DateTime, List<Event>>{
                                    date: eventList
                                  };
                                  kEvents.addEntries(elem.entries);
                                  setAppointment(date);
                                  print(kEvents[date]);
                                }
                              } else {
                                // kEvents[_selectedDay!] = [
                                //   Event(title: _eventController.text)
                                // ];
                              }
                            }
                            Navigator.pop(context);
                            _processController.clear();
                            _stepController.clear();
                            _hourController.clear();
                            _minuteController.clear();
                            _descriptionController.clear();
                            setState(() {});
                            return;
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Column(children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            focusedDay: _focusedDay,
            eventLoader: _getEventsForDay,
            headerVisible: true,
            sixWeekMonthsEnforced: true,
            shouldFillViewport: false,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800)),
            calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                    color: Color(0xFF29C9B3), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: Color(0xFF29C9B3), shape: BoxShape.circle),
                todayTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _selectedEvents.value = _getEventsForDay(_selectedDay!);
              fetchEvents();
            },
            onDaySelected: _onDaySelected,
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
                        onTap: () {
                          _showMyDialog(
                              appointment: value[index]); // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const CardDel()),
                          // );
                        },
                        title: Text(
                            '${value[index].date.hour}h${value[index].date.minute} : ${value[index].stepTitle} - ${value[index].processTitle}\n${value[index].stepDescription}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]));
  }

  Future<void> _showMyDialog({required Event appointment}) async {
    var process = appointment.userProcessId;
    var step = appointment.stepId;
    var date = appointment.date;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modify appointment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to delete the appointment'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                if (kEvents[_selectedDay] != null) {
                  kEvents[_selectedDay]!
                      .indexWhere((element) => element.date == date);
                }
                deleteAppointment(process, step);
                print("sucessfully deleted event");
                const SnackBar(
                  content: Text('Successfully deleted.'),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAppointment(process, step) async {
    final email = globals.email;

    final response = await http.get(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/calendar/delete?user_process_id=$process&step_id=$step"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      print(response.body);
      throw Exception("Failed to delete calendar event");
    }
  }
}

Future<void> setAppointment(date) async {
  final email = globals.email;

  final response = await http.post(
      Uri.parse("${dotenv.get('SERVER_URL')}/calendar/set"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
          {"user_process_id": "5", "step_id": "24", "date": date.toString()}));

  if (response.statusCode == 200) {
    return;
  } else {
    print(response.body);
    throw Exception("Failed to set calendar event");
  }
}


//delete?user_process_id=5&step_id=22