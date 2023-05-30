import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paperwork/calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> setCalendarEvent(
    String date, int userProcessId, int stepId) async {
  final String serverUrl = dotenv.get('SERVER_URL');
  final Uri url = Uri.parse('$serverUrl/calendar/set');
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final String body = json.encode({
    "date": date,
    "user_process_id": userProcessId.toString(),
    "step_id": stepId.toString(),
  });
  final http.Response response =
      await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    return json.decode(response.body)['message'];
  } else {
    throw Exception('Failed to set event');
  }
}

class CalendarFormAdd extends StatefulWidget {
  final UserProcessData userProcessData;
  const CalendarFormAdd({required this.userProcessData, super.key});

  @override
  State<CalendarFormAdd> createState() => _CalendarFormAddState();
}

class _CalendarFormAddState extends State<CalendarFormAdd> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int? _processDropDownValue;
  int? _stepDropDownValue;

  @override
  void initState() {
    _processDropDownValue = widget.userProcessData.userProcess.first.id;
    _stepDropDownValue = widget.userProcessData.userProcessStep
        .firstWhere((element) => element.processId == _processDropDownValue)
        .stepId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
        leading: IconButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/calendar'),
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Add Event'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                    ),
                    onPressed: () async {
                      DateTime dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.utc(1970, 01, 01),
                            lastDate: DateTime.utc(2070, 01, 01),
                          ) ??
                          DateTime.now();
                      setState(() => _selectedDate = dateTime);
                    },
                    child: Text(
                      _selectedDate.toString().substring(0, 10),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      TimeOfDay timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ) ??
                          TimeOfDay.now();
                      setState(() => _selectedTime = timeOfDay);
                    },
                    child: Text(
                      _selectedTime.toString().substring(10, 15),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DropdownButtonFormField<int>(
                isExpanded: true,
                value: _processDropDownValue,
                onChanged: (value) =>
                    setState(() => _processDropDownValue = value),
                items: widget.userProcessData.userProcess
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.title),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DropdownButtonFormField<int>(
                isExpanded: true,
                value: _stepDropDownValue,
                onChanged: (value) =>
                    setState(() => _stepDropDownValue = value),
                items: widget.userProcessData.userProcessStep
                    .where(
                        (element) => element.processId == _processDropDownValue)
                    .map((e) => DropdownMenuItem(
                          value: e.stepId,
                          child: Text('${e.stepId} - ${e.title}'),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 96, 128, 118)),
                ),
                onPressed: () async {
                  if (_processDropDownValue != null &&
                      _stepDropDownValue != null) {
                    final String date =
                        '${_selectedDate.toString().substring(0, 10)} ${_selectedTime.toString().substring(10, 15)}:00';
                    await setCalendarEvent(
                            date, _processDropDownValue!, _stepDropDownValue!)
                        .then(
                      (value) => ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(value)),
                        ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}