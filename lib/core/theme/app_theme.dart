import 'package:flutter/material.dart';
import 'colors.style.dart';

final ThemeData appThemeData = ThemeData(
  fontFamily: "Poppins",
  primaryColor: IColors.primary,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: IColors.primary,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: IColors.primary,
    unselectedLabelColor: IColors.mainTextColor,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: IColors.primary,
          width: 3,
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      letterSpacing: 2,
    ),
    centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(32),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: IColors.primary,
    unselectedItemColor: Colors.grey,
    elevation: 10,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: IColors.primary,
      shape: const StadiumBorder(),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: IColors.primary,
      shape: const StadiumBorder(),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: IColors.mainTextColor,
      letterSpacing: 1,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w200,
      color: IColors.mainTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: IColors.mainTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w200,
      color: IColors.mainTextColor,
      letterSpacing: 0,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.all(4),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide.none),
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    hintStyle: TextStyle(
      fontSize: 14,
      color: IColors.hintTextColor,
      fontWeight: FontWeight.w400,
    ),
  ),
);
