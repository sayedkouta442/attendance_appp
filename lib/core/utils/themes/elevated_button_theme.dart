import 'package:attendance_appp/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CElevatedButtonTheme {
  CElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 16, color: Colors.white),
      ),
      iconColor: WidgetStatePropertyAll(Colors.white),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      alignment: Alignment.center,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 16, color: Colors.white),
      ),
      iconColor: WidgetStatePropertyAll(Colors.white),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      alignment: Alignment.center,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  );
}
