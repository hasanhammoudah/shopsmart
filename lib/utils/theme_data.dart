import 'package:flutter/material.dart';
import 'package:shopsmart_users/utils/app_color.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        backgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        elevation: 0,
        titleTextStyle:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
      ),
    );
  }
}
