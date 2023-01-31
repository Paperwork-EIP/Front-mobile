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
    final response = await http.post(
        Uri.parse("${dotenv.get('SERVER_URL')}/userProcess/add"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "process_title": processName,
          "user_eamil": email,
          "questions": resQuestion,
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
