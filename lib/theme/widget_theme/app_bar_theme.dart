import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';

import 'colors_and_text_style.dart';

AppBarTheme appBarThemeLight = const AppBarTheme(
    titleTextStyle: TextStyle(
        color: ThemeColors.primaryTextColor,
        fontSize: SizeConstant.font24,
        fontWeight: FontWeight.w400),
    backgroundColor: ThemeColors.backgroundColor,
    foregroundColor: ThemeColors.primaryTextColor);