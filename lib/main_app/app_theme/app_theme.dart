import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {



  static Color orange = Color(0xfffd7e14);
  static Color danger = Color(0xffdc3545);
  static Color warning = Color(0xffffc107);
  static Color dark = Color(0xff343a40);
  static Color light = Color(0xfff8f9fa);
  static Color primary = Color(0xff007bff);
  static Color grey = Color(0xff6c757d);


//Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);

//  static Color colorPrimary = Color(0xff5FB562);
//  static Color colorPrimaryDark = Color(0xff91ff95);
//  static Color colorAccentLight = Colors.green[800];
//  static Color colorAccentDark = Colors.green[300];


//  static Color colorPrimary = Color(0xFFFB415B);
  static Color colorPrimary = Color(0xff0D4082);
//  static Color colorPrimaryDark = Color(0xffff7d8e);
  static Color colorPrimaryDark = Color(0xff173374);

  static Color colorAccentLight = Color(0xFFEE5623);
  static Color colorAccentDark = Color(0xffff9875);



  static Color lightBG = Colors.grey[100];
  static Color lightScaffoldColor = Colors.white;

  static Color darkBG = Colors.grey[900];
  static Color darkScaffoldColor = Colors.grey[800];

  static Color textColorBlack = Colors.black;
  static Color textColorWhite = Colors.grey[100];
  static Color darkErrorColor = Color(0xffff5630);

  // Exam Screen
  static Color attemptedColor = Colors.green;
  static Color notAttemptedColor = Colors.grey[500];
  static Color markedForReviewColor = Colors.orange[700];


  static var defaultLinearGradient = LinearGradient(
//      colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
      colors: [colorPrimary, colorPrimaryDark],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft);

  static var lightLinearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.grey[100], Colors.white]
  );

  static var darkLinearGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.grey[600], Colors.grey[500]]
  );

  var fontFamily = GoogleFonts.roboto().fontFamily;

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      backgroundColor: lightScaffoldColor,
      primaryColor: colorPrimary,
      accentColor: colorAccentLight,
      buttonTheme: ButtonThemeData(buttonColor: colorPrimary),
      scaffoldBackgroundColor: lightBG,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
          display1: TextStyle(
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
          title: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          )),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: darkBG),
      ));

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    errorColor: darkErrorColor,
    backgroundColor: darkBG,
    primaryColor: colorPrimaryDark,
    accentColor: colorAccentDark,
    scaffoldBackgroundColor: darkScaffoldColor,
    cursorColor: colorAccentLight,
    appBarTheme: AppBarTheme(
      color: darkBG,
      elevation: 0,
      iconTheme: IconThemeData(color: lightBG),
      actionsIconTheme: IconThemeData(color: lightBG),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.grey[100])),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: lightBG),
        hintStyle: TextStyle(color: Colors.grey)),
    textTheme:  GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).copyWith(
        display1: TextStyle(
          fontSize: 26,
        ),
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
        body1: TextStyle(color: Colors.grey[100])),
  );
}
