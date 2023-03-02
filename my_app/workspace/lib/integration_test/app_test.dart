import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../profile/profile.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the profile',
        (tester) async {
      // app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextButton));

      // await tester.pumpAndSettle();

      // await tester.tap(find.text('Logout'));
      // await tester.tap(find.text('Calendar'));
      // await tester.tap(find.text('Settings'));
    });
  });
}
