import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/auth/auth.dart';
import 'package:my_app/home/view/Header.dart';
import 'package:my_app/propal_add.dart';
import 'package:my_app/calendar.dart';
import 'package:my_app/profile/profile.dart';
import 'package:my_app/quizz/process/process.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:my_app/global.dart' as globals;

class OngoingProcess {
  final String message;
  final response;

  const OngoingProcess({required this.message, required this.response});

  factory OngoingProcess.fromJson(Map<String, dynamic> json) {
    return OngoingProcess(
      message: json['message'],
      response: json['response'],
    );
  }
}

Future<OngoingProcess> getOngoingProcess({
  required String email,
}) async {
  var response;
  response = await http.get(
    Uri.parse(
        "${dotenv.get('SERVER_URL')}/userProcess/getUserProcesses?user_email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    return OngoingProcess.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load Process');
  }
}

class Calendar {
  final String message;
  final appoinment;

  const Calendar({
    required this.message,
    required this.appoinment,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    return Calendar(
      message: json['message'],
      appoinment: json['appoinment'],
    );
  }
}

Future<Calendar> getCalendar({
  required String email,
}) async {
  var response;
  response = await http.get(
    Uri.parse("${dotenv.get('SERVER_URL')}/calendar/getAll?email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    return Calendar.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load calendar');
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String email = globals.email;

  final String finishedProcess = 'None';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Header(closeDrawer: _closeDrawer, openDrawer: _openDrawer)),
        drawer: NavBar(closeDrawer: _closeDrawer),
        body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 800,
                  width: 420,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 100,
                        child: FutureBuilder<Calendar>(
                            future: getCalendar(email: email),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.appoinment.length != 0) {
                                var date = snapshot.data!.appoinment[0]['date'];
                                var title =
                                    snapshot.data!.appoinment[0]['step_title'];
                                date = DateTime.parse(date);
                                var hours = DateFormat('jm').format(date);
                                date = DateFormat('MMMMEEEEd').format(date);
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 125,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Text(date,
                                              softWrap: true,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                      const VerticalDivider(),
                                      // showRDV
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 15.0),
                                            child: Text(title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 5.0),
                                            child: Text(hours,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                )),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.insert_drive_file_outlined,
                                        color: Color(0xFF29C9B3),
                                        size: 100,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: const Text('Loading',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                );
                              }
                            }),
                      ),
                      SizedBox(
                          width: 400,
                          height: 300,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text('Ongoing process',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                                const Divider(),
                                FutureBuilder<OngoingProcess>(
                                    future: getOngoingProcess(email: email),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return (Column(children: [
                                          for (var i = 0;
                                              i <
                                                  snapshot
                                                      .data!.response.length;
                                              i++)
                                            if (snapshot.data!.response[i]
                                                    ['is_done'] ==
                                                false) ...{
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                            horizontal: 10.0,
                                                            vertical: 10.0),
                                                    child: Text(
                                                        snapshot.data!
                                                                .response[i]
                                                            ['process_title'],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color(0xFF29C9B3),
                                                        )),
                                                  )
                                                ],
                                              )
                                            }
                                        ]));
                                      } else {
                                        return (const Text(
                                            'no current process'));
                                      }
                                    }),
                              ],
                            ),
                          )),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 40),
                          backgroundColor: const Color(0xFFFC6976),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Process()),
                          );
                        },
                        child: const Text("Start a process"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
