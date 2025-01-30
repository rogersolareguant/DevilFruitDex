import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get standard {
    return ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 220, 10, 45),
        dialogBackgroundColor: Colors.white,
        cardColor: const Color.fromARGB(255, 252, 219, 219),
        canvasColor: Colors.grey,
        appBarTheme: _appBarTheme,
        popupMenuTheme: _popupMenuTheme,
        hintColor: Colors.grey,
        focusColor: Colors.black,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 220, 10, 45)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Header',
              color: Colors.white),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Header',
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Header',
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black),
          headlineLarge: TextStyle(
              color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 14, color: Colors.grey),
          displayMedium: TextStyle(fontSize: 20, color: Colors.black),
        ));
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(backgroundColor: Color.fromARGB(255, 220, 10, 45));
  }

  static PopupMenuThemeData get _popupMenuTheme {
    return const PopupMenuThemeData(color: Colors.white);
  }

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 28, 30),
        dialogBackgroundColor: const Color.fromARGB(255, 44, 44, 46),
        cardColor: const Color.fromARGB(255, 58, 58, 60),
        canvasColor: Colors.black,
        appBarTheme: _appBarThemeDark,
        popupMenuTheme: _popupMenuThemeDark,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Header',
              color: Colors.white),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Header',
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Header',
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(
              color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 14, color: Colors.grey),
          displayMedium: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  static AppBarTheme get _appBarThemeDark {
    return const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
    );
  }

  static PopupMenuThemeData get _popupMenuThemeDark {
    return const PopupMenuThemeData(
      color: Color.fromARGB(255, 58, 58, 60),
    );
  }
}
