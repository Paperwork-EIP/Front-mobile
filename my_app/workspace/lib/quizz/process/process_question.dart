import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../global.dart';

class ProcessQuestion {
  List<dynamic>? question;

  ProcessQuestion({
    required this.question,
  });

  factory ProcessQuestion.fromJson(Map<String, dynamic> json) {
    return ProcessQuestion(
      question: json['questions'],
    );
  }

  static Future<bool> fetchResultQuizz(
      resQuestion, processName, context) async {
        print('resQuestion of the quizz = $resQuestion');
    final response = await http.post(
        Uri.parse("${dotenv.get('SERVER_URL')}/userProcess/add"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "process_title": processName,
          "user_token": token,
          "questions": resQuestion,
        }));

    if (response.statusCode == 200) {
      print('response.body creation du process = ${response.body}');
      return true;
    } else {
      // print('resQuestion = $resQuestion');
      throw Exception('Failed to load album');
    }
  }
}

class ProcessName {
  List<dynamic>? title;

  List<dynamic>? stockedTitle;

  ProcessName({
    required this.title,
  });

  factory ProcessName.fromJson(Map<String, dynamic> json) {
    return ProcessName(
      title: json['response'],
    );
  }

  static List<String> processList(parsedJson) {
    var res = parsedJson['response'];
    String elem;
    List<String> tab = [];

    for (var i in res) {
      elem = i['title'];
      tab.add(elem);
    }
    return tab;
  }

  static Future<List<String>> fetchProcessName() async {
    List<String> list;
    final response = await http.get(
      Uri.parse("${dotenv.get('SERVER_URL')}/process/getAll?language=$language"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    list = processList(jsonDecode(response.body));

    if (response.statusCode == 200) {
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
