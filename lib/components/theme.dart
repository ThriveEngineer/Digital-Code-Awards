import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: const Color.fromARGB(255, 16, 15, 15),
    secondary: const Color.fromARGB(255, 28, 27, 26),
    tertiary: const Color.fromARGB(255, 158, 158, 151),
    inversePrimary: const Color.fromARGB(255, 206, 205, 195),
  )
);