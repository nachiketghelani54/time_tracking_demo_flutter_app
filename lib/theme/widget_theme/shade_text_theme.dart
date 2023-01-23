import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';

import 'colors_and_text_style.dart';

TextTheme shadeTextThemeLight = TextTheme(
  headline1: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  headline2: const TextStyle(
      color: ShadeColors.titleColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline3: const TextStyle(
    color: ShadeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: const TextStyle(
      color: ShadeColors.backgroundColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: const TextStyle(
      color: ShadeColors.hintColor,
      fontSize: 12,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
    fontSize: 12, color: TaskColors.lightBlackColor),
  subtitle1: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w400),
  subtitle2: const TextStyle(fontSize: 17),
  headlineLarge: TextStyle(
      color: ShadeColors.dIconColor, fontSize: 25, fontWeight: FontWeight.w400),
  bodyText1: TextStyle(
      fontSize: 16, color: Colors.white),
  bodyText2: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 17,
      fontWeight: FontWeight.w400),
);

TextTheme shadeTextThemeDark = TextTheme(
  headline1: TextStyle(
      color: ShadeColors.dBackgroundColor, fontSize: 14, fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ShadeColors.dTitleColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ShadeColors.dBackgroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color:  ShadeColors.dPrimaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ShadeColors.dHintColor, fontSize: 12, fontWeight: FontWeight.w400),
  headline6: TextStyle(
       fontSize: 12, color: TaskColors.backgroundColor),
  headlineLarge: TextStyle(
      color: ShadeColors.dBackgroundColor, fontSize: 25, fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      color: ShadeColors.dBackgroundColor, fontSize: 18, fontWeight: FontWeight.w400),
  subtitle2: const TextStyle(fontSize: 17),
  bodyText1: TextStyle(
      fontSize: 16, color: Colors.white),
  bodyText2: TextStyle(
      color: ShadeColors.dBackgroundColor, fontSize: 17, fontWeight: FontWeight.w400),
);

TextTheme shadeTextThemeRed = TextTheme(
  headline1: TextStyle(
      color: ShadeColors.rBackgroundColor, fontSize: 14, fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ShadeColors.rTitleColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ShadeColors.rBackgroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color:  ShadeColors.rPrimaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ShadeColors.rHintColor, fontSize: 12, fontWeight: FontWeight.w400),
  headline6: TextStyle(
      fontSize: 12, color: TaskColors.backgroundColor),
  headlineLarge: TextStyle(
      color: ShadeColors.rBackgroundColor, fontSize: 25, fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      color: ShadeColors.rBackgroundColor, fontSize: 18, fontWeight: FontWeight.w400),
  subtitle2: const TextStyle(fontSize: 17),
  bodyText1: TextStyle(
       fontSize: 16, color: Colors.white),
  bodyText2: TextStyle(
      color: ShadeColors.rBackgroundColor, fontSize: 17, fontWeight: FontWeight.w400),
);
