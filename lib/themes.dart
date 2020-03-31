import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.tealAccent[100],
  brightness: Brightness.dark,
  backgroundColor: Colors.black87,
  accentColor: Colors.indigo[200],
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  textTheme: textTheme.apply(
    bodyColor: Colors.white70
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    textTheme: textTheme.apply(
      bodyColor: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    )
  )
);

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  brightness: Brightness.light,
  backgroundColor: Colors.red,
  accentColor: Colors.indigo,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  textTheme: textTheme.apply(
    bodyColor: Colors.black87
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    textTheme: textTheme.apply(
      bodyColor: Colors.black
    ),
    iconTheme: IconThemeData(
      color: Colors.black
    )
  )
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final textTheme = TextTheme(
  headline2: GoogleFonts.notoSerif(
    fontWeight: FontWeight.bold,
    fontSize: 62,
    letterSpacing: -0.5
  ),
  headline3: GoogleFonts.notoSerif(
    fontWeight: FontWeight.normal,
    fontSize: 49,
    letterSpacing: 0
  ),
  headline6: GoogleFonts.notoSerif(
    fontWeight: FontWeight.w500,
    fontSize: 21,
    letterSpacing: 0.15
  ),
  subtitle1: GoogleFonts.notoSerif(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.notoSerif(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
  )
);