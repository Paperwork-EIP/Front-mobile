import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/home/view/Header.dart';
import 'package:my_app/home/view/home_page.dart';

import 'package:http/http.dart' as http;

void main() {
  const email = 'test@test.test';
  const headers = {
    "Content-Type": "application/json",
  };
  const url = 'http://54.86.209.237:8080';

  group('OngoingProcess', () {
    test('fromJson', () {
      final Map<String, dynamic> json = {
        'message': 'Hello World',
        'response': {'something': 'yes'}
      };

      final calendar = OngoingProcess.fromJson(json);

      expect(calendar.message, equals('Hello World'));
      expect(calendar.response, equals({'something': 'yes'}));
    });
    test('should return a valid response data', () async {
      final response = await http.get(
        Uri.parse("$url/userProcess/getUserProcesses?user_email=$email"),
        headers: headers,
      );
      final result = json.decode(response.body);

      expect(result, isNotNull);
    });

    test('should throw an exception when invalid email is passed', () async {
      const invalidEmail = 'invalid@example';

      expect(() => getOngoingProcess(token: invalidEmail), throwsException);
    });
  });
  group('Calendar', () {
    test('fromJson', () {
      final Map<String, dynamic> json = {
        'message': 'Hello World',
        'appoinment': 'meeting'
      };

      final calendar = Calendar.fromJson(json);

      expect(calendar.message, equals('Hello World'));
      expect(calendar.appoinment, equals('meeting'));
    });
    test('should return a valid response data', () async {
      final response = await http.get(
        Uri.parse("$url/calendar/getAll?token=$email"),
        headers: headers,
      );
      final result = json.decode(response.body);

      expect(result, isNotNull);
    });

    test('should throw an exception when invalid email is passed', () async {
      const invalidEmail = 'invalid@example';

      expect(() => getCalendar(token: invalidEmail), throwsException);
    });
  });
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_app/home/view/Header.dart';
// import 'package:my_app/home/view/home_page.dart';

// import 'package:http/http.dart' as http;

// // void main() {
//   // Detecter les widgets presents
//   // group('HomePage', () {
//   //   // final widget = HomePage().createElement().state as HomePage;
//   //   Widget buildTestableWidget(Widget widget) {
//   //     return MediaQuery(
//   //         data: const MediaQueryData(), child: MaterialApp(home: widget));
//   //   }
//   //   testWidgets('Widget build test', (WidgetTester tester) async {
//   //     await tester.pumpWidget(buildTestableWidget(HomePage()));
//   //     await tester.pumpAndSettle();

//   //     expect(find.byType(Scaffold), findsOneWidget);
//   //     expect(find.byType(Header), findsOneWidget);
//   //     // expect(find.byType(NavBar), findsOneWidget);
//   //     expect(find.byType(Container), findsNWidgets(2));
//   //     expect(find.byType(ConstrainedBox), findsOneWidget);
//   //     expect(find.byType(Column), findsNWidgets(2));
//   //     expect(find.byType(SizedBox), findsNWidgets(2));
//   //     expect(find.byType(FutureBuilder), findsOneWidget);
//   //   });
//   // });
// // }
