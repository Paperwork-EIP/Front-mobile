import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:my_app/app_localisation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppLocalizations', () {
    AppLocalizations appLocalizations = AppLocalizations(const Locale('en'));

    // test('Translation should return correct localized string', () {
    //   when(appLocalizations.translate('hello')).thenReturn('Hello');
    //   String translatedHello = appLocalizations.translate('hello');
    //   expect(translatedHello, 'Hello');

    //   when(appLocalizations.translate('world')).thenReturn('World');
    //   String translatedWorld = appLocalizations.translate('world');
    //   expect(translatedWorld, 'World');
    // });

    test('Translation of non-existent key should return null', () {
      String translated = appLocalizations.translate('nonexistent');
      expect(translated, 'null');
    });
  });
}
