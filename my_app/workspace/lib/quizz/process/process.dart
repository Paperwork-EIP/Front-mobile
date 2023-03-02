import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/quizz/process/process_question.dart';
import 'package:my_app/quizz/result/result_quizz.dart';
import '../../global.dart';

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

List<int> listy = [];

List<String> stepList(parsedJson) {
  List<String> list = [];
  ProcessQuestion obj = ProcessQuestion.fromJson(parsedJson);

  for (var i in obj.question!) {
    list.add(i[1]);
    listy.add(i[0]);
  }
  return list;
}

Future<List<String>> fetchQuestions(processName) async {
  List<String> parsedJson;

  final response = await http.get(
    Uri.parse(
        "${dotenv.get('SERVER_URL')}/processQuestions/get?title=$processName&user_email=$email"),
    headers: {
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    parsedJson = stepList(jsonDecode(response.body));
    return parsedJson;
  } else if (response.statusCode == 404) {
    return ["404"];
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
  late Future<List<String>> futureQuestion;

  @override
  void initState() {
    super.initState();
    futureQuestion = fetchQuestions(widget.processName);
  }

  @override
  Widget build(BuildContext context) {
    String? processName = widget.processName;

    void increment(int id, bool value) {
      if (count < listy.length - 1) {
        setState(() {
          count = count + 1;
          res.add([listy[count], value]);
        });
      } else {
        res.add([listy[count], value]);
        ProcessQuestion.fetchResultQuizz(res, processName, context);

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Center(
                    child: FutureBuilder<List<String>>(
                        future: futureQuestion,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data![0] == '404') {
                              return const Text("Trouve un moyen c'est pas normal");
                            } else {
                              return Text(
                                snapshot.data![count],
                                style: TextStyle(
                                    // color: Colors.black.withOpacity(0.6),
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        })),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 228, 117, 126),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      onPressed: () {
                        increment(count, false);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 166, 221, 204),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      onPressed: () {
                        increment(count, true);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
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

  late Future<List<String>> futureProcess;

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
          title: const Text('Choose a process',
              style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<String>>(
                  future: futureProcess,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No process available for now, Try later",
                            style: TextStyle(
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
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dropDown(BuildContext context, final List<String> items) {

      Color setColor(bool value) {
      if (value) {
        return const Color.fromARGB(242, 211, 207, 210);
      } else {
        return const Color.fromARGB(238, 61, 36, 48);
      }
    }

    return (DropdownButton<String>(
      value: dropdownValue,
      hint: const Text('Select Process'),
      icon: const Icon(
        Icons.arrow_downward,
        size: 20,
        color: Color.fromARGB(255, 166, 221, 204),
      ),
      underline: Container(
        height: 1,
        color: const Color.fromARGB(255, 228, 117, 126),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      disabledHint: const Text("Disabled"),
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
