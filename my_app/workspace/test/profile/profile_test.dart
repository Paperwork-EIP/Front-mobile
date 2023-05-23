import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:my_app/home/view/Header.dart';
import 'package:my_app/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  group('Profile widget', () {
    Widget buildTestableWidget(Widget widget) {
      return MediaQuery(
          data: const MediaQueryData(), child: MaterialApp(home: widget));
    }

    testWidgets('find element', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(Profile()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // expect(find.text('content'), findsOneWidget);
      // expect(find.text('MyApp'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(1));

      // await tester.pumpWidget(buildTestableWidget(MyForm()));
      // await tester.pumpAndSettle(const Duration(seconds: 1));
      // expect(find.byType(TextFormField), findsNWidgets(3));
      // expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
