import 'dart:convert';
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
      print('processName = $processName');
      print('resQuestion = $resQuestion');
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
      return true;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class ProcessName {
  List<dynamic>? title;

  ProcessName({
    required this.title,
  });

  factory ProcessName.fromJson(Map<String, dynamic> json) {
    return ProcessName(
      title: json['response'],
    );
  }

  static List<List<String>> processList(parsedJson) {
    var res = parsedJson['response'];
    String elem;
    String elem2;
    List<List<String>> tab = [];

    for (var i in res) {
      elem = i['title'];
      elem2 = i['stocked_title'];
      tab.add([elem, elem2]);
    }
    return tab;
  }

  static Future<List<List<String>>> fetchProcessName() async {
    List<List<String>> list;

    final response = await http.get(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/process/getAll?language=$language"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(response.statusCode);
    list = processList(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print(list);
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
