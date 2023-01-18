import 'package:flutter/material.dart';

import 'colors_and_text_style.dart';

AppBarTheme shadeAppBarThemeLight = const AppBarTheme(
    titleTextStyle: TextStyle(
        color: ShadeColors.primaryTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w400),
    backgroundColor: ShadeColors.backgroundColor,
    foregroundColor: ShadeColors.primaryTextColor);

AppBarTheme shadeAppBarThemeDark = AppBarTheme(
  titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
  backgroundColor: darkColor,
);
