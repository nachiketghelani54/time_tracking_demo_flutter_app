import 'package:flutter/material.dart';

import 'colors_and_text_style.dart';

/// ElevatedButtonThemeData
ElevatedButtonThemeData shadeElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        color: ThemeColors.backgroundColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(ThemeColors.primaryColor),
    foregroundColor: MaterialStateProperty.all(ThemeColors.backgroundColor),
    minimumSize: MaterialStateProperty.all(
      const Size(300, 50),
    ),
  ),
);
