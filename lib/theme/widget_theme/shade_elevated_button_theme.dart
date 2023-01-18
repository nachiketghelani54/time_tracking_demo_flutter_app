import 'package:flutter/material.dart';

import 'colors_and_text_style.dart';

ElevatedButtonThemeData shadeElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(ShadeColors.primaryColor),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    minimumSize: MaterialStateProperty.all(
      const Size(300, 50),
    ),
  ),
);
