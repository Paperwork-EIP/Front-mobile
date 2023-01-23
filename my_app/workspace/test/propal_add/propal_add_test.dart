import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/propal_add.dart';
import 'package:http/http.dart' as http;

void main() {
  const email = 'test@test.test';
  const headers = {
    "Content-Type": "application/json",
  };
  const url = 'http://54.86.209.237:8080';

  const title = 'test2@test.test';
  const description = 'Sandros';
  const content = 'I want to submit ';
  group('Submit Process Idea', () {
    test('should return a valid response data', () async {
      final response = await http.post(
        Uri.parse("$url/process/add"),
        headers: headers,
        body: json.encode({"title": title, "description": description, "content": content, "email": email,}),
      );
      final result = json.decode(response.body);

      expect(result, isNotNull);
    });
  });
}
