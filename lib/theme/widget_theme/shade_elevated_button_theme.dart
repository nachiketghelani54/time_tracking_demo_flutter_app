import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';

import 'colors_and_text_style.dart';

/// ElevatedButtonThemeData
ElevatedButtonThemeData shadeElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        color: ThemeColors.backgroundColor,
        fontSize: SizeConstant.font16,
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
