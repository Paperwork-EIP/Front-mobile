import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../global.dart';

class ToDo {
  int? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['step_id'],
      todoText: json['step_description'],
      isDone: json['is_done'],
    );
  }

  static List<ToDo> todoList(parsedJson) {
    var res = parsedJson['response'];
    ToDo elem;
    List<ToDo> tab = [];

    for (var i in res) {
      elem = ToDo.fromJson(i);
      tab.add(elem);
    }
    return tab;
  }

  static Future<List<ToDo>> fetchTodoList(processName) async {
    final response = await http.get(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/userProcess/getUserSteps?user_email=$email&process_title=$processName"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      return todoList(parsedJson);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<bool> fetchUpdateData(resStep, processName) async {
    final response = await http.post(
        Uri.parse("${dotenv.get('SERVER_URL')}/userProcess/add"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "process_title": processName,
          "user_email": email,
          "step": resStep,
        }));

    if (response.statusCode == 200) {
      print("c'est good");
      return true;
    } else {
      print("c'est pas bon je ne sais pas pk");
      print(response);
      throw Exception('Failed to load album');
    }
  }
}
