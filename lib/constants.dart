import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(0, 115, 54, 1);
const Color secondaryColor = Color.fromARGB(125, 0, 115, 54);
const Color tertiaryColor = Color.fromARGB(255, 255, 255, 255);


ThemeData semillasTheme = ThemeData(
  fontFamily: 'Montserrat',
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    extendedTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    extendedPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    backgroundColor: primaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    border: const OutlineInputBorder(borderSide: BorderSide.none),
  ),
  primaryColor: primaryColor,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity
);