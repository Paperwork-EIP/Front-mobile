import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/auth/auth.dart';
import 'package:my_app/home/view/Header.dart';
import 'package:my_app/propal_add.dart';
import 'package:my_app/calendar.dart';
import 'package:my_app/profile/profile.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:my_app/global.dart' as globals;

import '../../quizz/result/result_quizz.dart';


class Process {
  final String message;
  final response;

  const Process({required this.message, required this.response});

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      message: json['message'],
      response: json['response'],
    );
  }
}

Future<Process> getOngoingProcess({
  required String email,
}) async {
  var response;
  // try {
  response = await http.get(
    Uri.parse(
        "${dotenv.get('SERVER_URL')}/userProcess/getUserProcesses?user_email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    // var jsonData = jsonDecode(response.body);
    // List<Process> process = [];

    // for(var u in jsonData) {
    //   Process processs = Process(u['message'], u['response']);
    //   process.add(processs);
    // }

    return Process.fromJson(jsonDecode(response.body));
  }
  // } catch (e) {
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
  // print(json.encode({
  //   'email': email,
  //   'password': password,
  // }));
  // try {
  response = await http.get(
    Uri.parse("${dotenv.get('SERVER_URL')}/calendar/getAll?email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
    // body: json.encode({"email": email, "password": password}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return Calendar.fromJson(jsonDecode(response.body));
    // var jsonData = jsonDecode(response.body);
    // print(jsonData);
    // return(json);
    // print(response.body);
    // _controller.add(AuthStatus.authenticated);
  }
  // } catch (e) {
  else {
    throw Exception('Failed to load calendar');
  }

  // print('r= $response');
  // print(e);
  // }
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
  // final date = getCalendar(email: 'test@test.test');

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
          // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                              // print('length' + snapshot.data!.appoinment.length);
                              // if (snapshot.data!)
                              if (snapshot.hasData &&
                                  snapshot.data!.appoinment.length != 0) {
                                var date = snapshot.data!.appoinment[0]['date'];
                                var title =
                                    snapshot.data!.appoinment[0]['step_title'];
                                date = DateTime.parse(date);
                                var hours = DateFormat('jm').format(date);
                                // DateFormat('yMMMMEEEEd').format(DateTime.now())
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
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // showDate
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
                                        // crossAxisAlignment: CrossAxisAlignment.center,
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
                              // Text(date);
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
                                // SingleChildScrollView(
                                //   child:
                                FutureBuilder<Process>(
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
                                            'No current process'));
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
                            MaterialPageRoute(builder: (context) => const ResultQuizz()),
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
