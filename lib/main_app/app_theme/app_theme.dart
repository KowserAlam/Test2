import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ///Neumorphic Colors
  static Color mC = Colors.grey.shade100;
  static Color mCL = Colors.white;
  static Color mCD = Colors.black.withOpacity(0.075);
  static Color mCC = Colors.green.withOpacity(0.65);
  static Color fCD = Colors.grey.shade700;
  static Color fCL = Colors.grey;
  static Color shadowColor = Colors.grey[100];
  static Color lightShadowColor = Colors.white;

  /// Oficion color
  static Color orange = Color(0xfffd7e14);
  static Color danger = Color(0xffdc3545);
  static Color warning = Color(0xffffc107);
  static Color dark = Color(0xff343a40);
  static Color lightGrey = Color(0xfff8f9fa);
  static Color primary = Color(0xff007bff);
  static Color grey = Color(0xff6c757d);

  static Color facebookColor = Color(0xff3D579E);
  static Color linkedInColor = Color(0xff0076B4);
  static Color twitterColor = Color(0xff55ABEE);

  static Color colorPrimary = Color(0xff0A5394);
  static Color colorPrimaryDark = Color(0xff1085eb);
  static Color colorAccent = Color(0xff1C4587);
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
      colors: [colorPrimary, colorAccent],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft);

  static var lightLinearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.grey[100], Colors.white]);

  static var darkLinearGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.grey[600], Colors.grey[500]]);

  var fontFamily = GoogleFonts.roboto().fontFamily;

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      backgroundColor: lightScaffoldColor,
      primaryColor: colorPrimary,
      accentColor: colorAccent,
      buttonTheme: ButtonThemeData(buttonColor: colorPrimary),
      scaffoldBackgroundColor: lightBG,
      textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    errorColor: darkErrorColor,
    backgroundColor: darkBG,
    primaryColor: colorPrimaryDark,
    accentColor: colorPrimaryDark,
    scaffoldBackgroundColor: darkScaffoldColor,
    cursorColor: colorAccent,
    appBarTheme: AppBarTheme(
      color: darkBG,
      elevation: 0,
      iconTheme: IconThemeData(color: lightBG),
      actionsIconTheme: IconThemeData(color: lightBG),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        title: TextStyle(
          color: lightBG,
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.grey[100])),
    textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).copyWith(
      title: TextStyle(
        color: lightBG,
      ),
      body1: TextStyle(color: Colors.grey[100]),
    ),
  );
}
