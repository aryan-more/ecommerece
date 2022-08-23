import 'package:flutter/material.dart';

extension AppThemeData on ThemeData {
  AppTheme get theme => brightness == Brightness.light ? lightTheme : darkTheme;
}

class AppTheme {
  final Color background;
  final Color action;
  final Color accent;
  final bool isLightTheme;
  final Color textColor;

  const AppTheme({
    required this.background,
    required this.action,
    required this.accent,
    required this.isLightTheme,
    required this.textColor,
  });
  static ThemeData themeData(AppTheme appTheme) {
    ThemeData base;
    if (appTheme.isLightTheme) {
      base = ThemeData.light();
    } else {
      base = ThemeData.dark();
    }

    return base.copyWith(
      scaffoldBackgroundColor: appTheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: appTheme.background,
        titleTextStyle: TextStyle(
          color: appTheme.textColor,
          fontSize: 25,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: appTheme.action),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: appTheme.action,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          fixedSize: const Size(
            double.infinity,
            50,
          ),
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appTheme.action,
        selectionColor: appTheme.accent,
        selectionHandleColor: appTheme.action,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: appTheme.action,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: appTheme.action,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: appTheme.action,
          ),
        ),
      ),
    );
  }
}

final lightTheme = AppTheme(
  background: Colors.white,
  action: Colors.purple,
  accent: Colors.purple[100]!,
  isLightTheme: true,
  textColor: Colors.black,
);
final darkTheme = AppTheme(
  background: Colors.black,
  action: Colors.purple,
  accent: Colors.purple[800]!,
  isLightTheme: false,
  textColor: Colors.white,
);
