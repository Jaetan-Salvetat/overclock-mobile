import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = _generateTheme(Brightness.light);
  static ThemeData darkTheme = _generateTheme(Brightness.dark);

  static ThemeData _generateTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
      brightness: brightness,
    );
  }
}
