import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoTheme {

  static Color backgroundGreen = const Color.fromRGBO(36, 161, 156, 1);
  static Color backgroundGreen2 = const Color.fromRGBO(42, 171, 238, 1);
  static Color backgroundGrey = const Color.fromRGBO(230, 230, 230, 1);
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color black = const Color.fromRGBO(0, 0, 0, 1);
  static Color textGrey = const Color.fromRGBO(118, 126, 140, 1);
  static Color ghostGrey = const Color.fromRGBO(169, 176, 197, 1);
  static Color red = const Color.fromRGBO(180, 17, 17, 1.0);

  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: white,
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.notoSans(fontSize: 32, color: black, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.notoSans(fontSize: 16, color: black, fontWeight: FontWeight.w600),
      bodySmall: GoogleFonts.notoSans(fontSize: 14, color: textGrey),
      bodyMedium: GoogleFonts.notoSans(fontSize: 18, color: black),
    ),
    appBarTheme: AppBarTheme(
      color: white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundGreen),
        foregroundColor: WidgetStateProperty.all(white),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.notoSans(fontSize: 18)
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 48))
      )
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: backgroundGreen
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      hintStyle: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ghostGrey,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: backgroundGreen,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: ghostGrey,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: backgroundGreen,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: backgroundGreen,
      elevation: 0,
    )
  );
}