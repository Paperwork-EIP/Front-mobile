import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/themes.dart';

void main() {
  test('Light theme data should have correct properties', () {
    expect(lightThemeData.primaryColor, const Color(0xFF29C9B3));
    expect(lightThemeData.brightness, Brightness.light);
    expect(lightThemeData.colorScheme.secondary, const Color(0xFFFC6976));
    expect(lightThemeData.appBarTheme.backgroundColor,
        const Color.fromARGB(255, 96, 128, 118));
  });

  // test('Dark theme data should have correct properties', () {
  //   expect(darkThemeData.primaryColor, const Color(0xFF29C9B3));
  //   expect(darkThemeData.brightness, Brightness.dark);
  //   expect(darkThemeData.colorScheme.secondary, const Color(0xFFFC6976));
  //   expect(darkThemeData.appBarTheme.backgroundColor,
  //       const Color.fromARGB(255, 65, 83, 78));
  // });
}
