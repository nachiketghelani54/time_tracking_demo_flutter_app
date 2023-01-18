import 'package:flutter/material.dart';

import 'colors_and_text_style.dart';

TextTheme shadeTextThemeLight = TextTheme(
  headline1: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  headline2: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline3: const TextStyle(
    color: ShadeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
      fontStyle: FontStyle.italic, fontSize: 12, color: darkIconColor2),
  subtitle1: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w400),
  subtitle2: const TextStyle(fontSize: 17),
  headlineLarge: TextStyle(
      color: darkIconColor, fontSize: 25, fontWeight: FontWeight.w400),
  bodyText1: TextStyle(
      fontStyle: FontStyle.italic, fontSize: 10, color: darkIconColor2),
  bodyText2: const TextStyle(
      color: ShadeColors.primaryTextColor,
      fontSize: 17,
      fontWeight: FontWeight.w400),
);

TextTheme shadeTextThemeDark = TextTheme(
  headline1: TextStyle(
      color: mainBackGroundColor, fontSize: 14, fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: mainBackGroundColor, fontSize: 16, fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: mainBackGroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color: mainBackGroundBlackColor,
      fontSize: 16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: mainBackGroundColor, fontSize: 12, fontWeight: FontWeight.w400),
  headline6: TextStyle(
      fontStyle: FontStyle.italic, fontSize: 12, color: darkIconColor2),
  headlineLarge: TextStyle(
      color: mainBackGroundColor, fontSize: 25, fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      color: mainBackGroundColor, fontSize: 18, fontWeight: FontWeight.w400),
  subtitle2: const TextStyle(fontSize: 17),
  bodyText1: TextStyle(
      fontStyle: FontStyle.italic, fontSize: 10, color: darkIconColor2),
  bodyText2: TextStyle(
      color: mainBackGroundColor, fontSize: 17, fontWeight: FontWeight.w400),
);
