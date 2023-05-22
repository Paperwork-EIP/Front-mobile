import 'package:flutter/material.dart';

var lightThemeData = ThemeData(
  primaryColor: const Color(0xFF29C9B3),
  brightness: Brightness.light,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFC6976)),
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromARGB(255, 96, 128, 118)),
);

var darkThemeData = ThemeData(
    primaryColor: const Color(0xFF29C9B3),
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFC6976)),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 65, 83, 78)));
