import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
        ),
        primarySwatch: Colors.deepPurple,
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
      );
}
