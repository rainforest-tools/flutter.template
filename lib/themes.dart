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
  ),
  colorScheme: darkColorScheme,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.tealAccent[100],
  )
);

final darkColorScheme = ColorScheme.dark(
  primary: Colors.tealAccent[100],
  primaryVariant: Colors.tealAccent[700],
  secondary: Colors.indigo[100],
  secondaryVariant: Colors.indigo[400],
  surface: Colors.black54,
  background: Colors.black54,
  error: Colors.red[200],
  onPrimary: Colors.black54,
  onSecondary: Colors.black54,
  onSurface: Colors.white70,
  onBackground: Colors.white70,
  onError: Colors.black54
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
  ),
  colorScheme: lightColorScheme,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.teal
  )
);

final lightColorScheme = ColorScheme.dark(
  primary: Colors.tealAccent[100],
  primaryVariant: Colors.tealAccent[700],
  secondary: Colors.indigo[100],
  secondaryVariant: Colors.indigo[400],
  surface: Colors.white70,
  background: Colors.white70,
  error: Colors.red[200],
  onPrimary: Colors.white70,
  onSecondary: Colors.white70,
  onSurface: Colors.black87,
  onBackground: Colors.black87,
  onError: Colors.white70
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
  headline4: GoogleFonts.notoSerif(
    fontWeight: FontWeight.normal,
    fontSize: 34,
    letterSpacing: 0.25
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
  ),
  bodyText1: GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.5
  ),
  caption: GoogleFonts.notoSerif(
    fontWeight: FontWeight.normal,
    fontSize: 10,
    letterSpacing: 0.4
  ),
  overline: GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    fontSize: 8,
    letterSpacing: 1.5
  )
);