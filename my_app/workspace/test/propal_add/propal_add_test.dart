// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:my_app/propal_add.dart';
// import 'package:http/http.dart' as http;

void main() {
  group('Add proposal widget', () {
    Widget buildTestableWidget(Widget widget) {
      return MediaQuery(
          data: const MediaQueryData(), child: MaterialApp(home: widget));
    }

    testWidgets('find element', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(AddPropal()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // expect(find.text('content'), findsOneWidget);
      // expect(find.text('MyApp'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
