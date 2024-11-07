import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

ThemeData darkTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: AppColors.accentColorFifty,
    ),
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    textTheme: getAppTextTheme(),
    scaffoldBackgroundColor: AppColors.darkModeBgColor,
    appBarTheme: getAppBarDarkTheme(),
    colorScheme: const ColorScheme.dark(
      background: AppColors.darkModeBgColor,
      primary: AppColors.darkModePrimaryColor,
      secondary: AppColors.darkModeSecondaryColor,

      // secondary:
    ));

AppBarTheme getAppBarDarkTheme() {
  return AppBarTheme(
    centerTitle: false,
    backgroundColor: AppColors.darkModeBgColor,
    titleTextStyle: getAppTextTheme().headlineMedium?.copyWith(
          color: AppColors.appWhite,
          fontWeight: FontWeight.w800,
        ),
    // iconTheme: const IconThemeData(
    //   color: AppColors.scaffoldTextColor,
    // ),
  );
}

TextTheme getAppTextTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
  );
}
