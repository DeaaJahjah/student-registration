import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff014D71);
const Color secondaryColor = Color(0xffB0A163);
const Color brown = Color(0xff9B9B9C);

const Color white = Color(0xffffffff);

final Color whitWithOpacity = white.withOpacity(0.3);

const String font = 'Questv1';
ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: white,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: white,
      centerTitle: false,
      titleTextStyle: TextStyle(color: primaryColor, fontFamily: font, fontSize: 24, fontWeight: FontWeight.bold)),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: primaryColor, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(color: primaryColor, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: primaryColor, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(color: white, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    bodyMedium: TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: white, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal),
    displayLarge: TextStyle(color: secondaryColor, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    displayMedium: TextStyle(color: brown, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(color: white, fontFamily: font, fontSize: 12, fontWeight: FontWeight.normal),
  ),
  // Text Form Field styl
);
