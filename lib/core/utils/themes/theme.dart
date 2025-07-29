import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/themes/elevated_button_theme.dart';
import 'package:attendance_appp/core/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.white, // Color(0xff4e80c3),
    scaffoldBackgroundColor: Color(0xfff8f8fc),
    textTheme: CTextTheme.lightTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xfff8f8fc),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xfff8f8fc),
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(.01),
      elevation: 0,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: CTextTheme.darkTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF121212),
        statusBarIconBrightness: Brightness.light,
      ),

      //  backgroundColor: Color(0xFF121212),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent, // Allow blur to show
      elevation: 0, // No shadow
    ),
  );
}
