import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paperwork/quizz/process/process_question.dart';
import 'package:paperwork/quizz/result/result_quizz.dart';
import '../../global.dart';
import 'dart:io';
// import '../../app_localisation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Quizz extends StatelessWidget {
  const Quizz({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 450,
          height: 300,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8.0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.grey.shade200,
            child: const StartProcess(),
          ),
        ),
      ],
    );
  }
}

List<Map> listy = [];

List<Map> stepList(parsedJson) {
  List<Map> list = [];
  ProcessQuestion obj = ProcessQuestion.fromJson(parsedJson);

  for (var i in obj.question!) {
    list.add(i);
    listy = list;
  }
  return list;
}

Future<List<Map>> fetchQuestions(processName) async {
  List<Map> parsedJson;

  final response = await http.get(
    Uri.parse(
        "${dotenv.get('SERVER_URL')}/processQuestions/get?title=$processName&language=$language"),
    headers: {
      "Content-Type": "application/json",
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    parsedJson = stepList(jsonDecode(response.body));
    return parsedJson;
  } else if (response.statusCode == 404) {
    return [
      {"status": "404"}
    ];
  } else {
    throw Exception('Failed to load album');
  }
}

class QuizzProcess extends StatefulWidget {
  final String? processName;
  const QuizzProcess({Key? key, required this.processName}) : super(key: key);

  @override
  State<QuizzProcess> createState() => _QuizzProcessState();
}

class _QuizzProcessState extends State<QuizzProcess> {
  var count = 0;
  var res = [];
  late Future<List<Map>> futureQuestion;

  @override
  void initState() {
    super.initState();
    futureQuestion = fetchQuestions(widget.processName);
  }

  @override
  Widget build(BuildContext context) {
    String? processName = widget.processName;

    void increment(int nb, bool value) {
      Map resStep = {"step_id": "", "response": ""};
      if (count < listy.length - 1) {
        resStep["step_id"] = listy[count]["step_id"];
        resStep["response"] = value;
        res.add(resStep);
      } else {
        resStep["step_id"] = listy[count]["step_id"];
        resStep["response"] = value;
        res.add(resStep);
        ProcessQuestion.fetchResultQuizz(res, processName, context);
        sleep(const Duration(seconds: 2, milliseconds: 500));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultQuizz(processName: processName)),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 450,
          height: 300,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8.0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(processName!,
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                FutureBuilder<List<Map>>(
                    future: futureQuestion,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data![0]["status"] == '404') {
                          return Text(
                            AppLocalizations.of(context)!.problemOccured,
                          );
                        } else {
                          return Stack(children: [
                            Text(
                              snapshot.data![count]["question"],
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 228, 117, 126),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        )),
                                    onPressed: () {
                                      increment(count, false);
                                      setState(() {
                                        if (count < listy.length - 1) {
                                          count = count + 1;
                                        }
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.no,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 166, 221, 204),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        )),
                                    onPressed: () {
                                      increment(count, true);
                                      setState(() {
                                        if (count < listy.length - 1) {
                                          count = count + 1;
                                        }
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.yes,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StartProcess extends StatefulWidget {
  const StartProcess({
    Key? key,
  }) : super(key: key);

  @override
  State<StartProcess> createState() => _StartProcessState();
}

class _StartProcessState extends State<StartProcess> {
  String? dropdownValue;

  late Future<List<List<String>>> futureProcess;

  @override
  void initState() {
    super.initState();
    futureProcess = ProcessName.fetchProcessName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // ignore: prefer_const_constructors
        ListTile(
          title: Text(AppLocalizations.of(context)!.chooseAprocess,
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<List<String>>>(
                  future: futureProcess,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.noProcessAvailable,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 98, 153, 141),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                            width: 200,
                            child: dropDown(context, snapshot.data!));
                      }
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const CircularProgressIndicator();
                  }),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    backgroundColor: Color.fromARGB(255, 166, 221, 204),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                onPressed: () {
                  if (dropdownValue != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QuizzProcess(processName: dropdownValue)),
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.start,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dropDown(BuildContext context, final List<List<String>> items) {
    Color setColor(bool value) {
      if (value) {
        return const Color.fromARGB(242, 211, 207, 210);
      } else {
        return const Color.fromARGB(238, 61, 36, 48);
      }
    }

    return (DropdownButton<String>(
      value: dropdownValue,
      hint: Text(
        AppLocalizations.of(context)!.selectProcess,
      ),
      icon: const Icon(
        Icons.arrow_downward,
        size: 20,
        color: Color.fromARGB(255, 166, 221, 204),
      ),
      underline: Container(
        height: 1,
        color: const Color.fromARGB(255, 228, 117, 126),
      ),
      items: items.map((List<String> item) {
        return DropdownMenuItem(
          value: item[1],
          child: Text(item[0]),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      disabledHint: Text(
        AppLocalizations.of(context)!.disabled,
      ),
      elevation: 4,
      style: TextStyle(
          color: setColor(Theme.of(context).brightness == Brightness.dark),
          fontSize: 18),
      iconDisabledColor: Colors.grey[350],
      iconEnabledColor: Colors.green,
      isExpanded: true,
    ));
  }
}
