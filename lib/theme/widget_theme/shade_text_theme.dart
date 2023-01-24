import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';

import 'colors_and_text_style.dart';

/// TextTheme
TextTheme shadeTextThemeLight = const TextTheme(
  headline1: TextStyle(
      color: ThemeColors.primaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ThemeColors.titleColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ThemeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color: ThemeColors.backgroundColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ThemeColors.hintColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: 12, color: TaskColors.lightBlackColor),
  subtitle1: TextStyle(
      color: ThemeColors.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w400),
  subtitle2: TextStyle(fontSize: 17),
  headlineLarge: TextStyle(
      color: ThemeColors.dIconColor, fontSize: 25, fontWeight: FontWeight.w400),
  bodyText1: TextStyle(fontSize: 16, color: TaskColors.backgroundColor),
  bodyText2: TextStyle(
      color: TaskColors.blackColor, fontSize: 16, fontWeight: FontWeight.w400),
);

TextTheme shadeTextThemeDark = const TextTheme(
  headline1: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ThemeColors.dTitleColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ThemeColors.dBackgroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color: ThemeColors.dPrimaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ThemeColors.dHintColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: 12, color: TaskColors.backgroundColor),
  headlineLarge: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: 25,
      fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: 18,
      fontWeight: FontWeight.w400),
  subtitle2: TextStyle(fontSize: 17),
  bodyText1: TextStyle(fontSize: 16, color: TaskColors.backgroundColor),
  bodyText2: TextStyle(
      color: TaskColors.backgroundColor,
      fontSize: 17,
      fontWeight: FontWeight.w400),
);
