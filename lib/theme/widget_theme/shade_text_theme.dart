import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';

import 'colors_and_text_style.dart';

/// TextTheme
TextTheme shadeTextThemeLight = const TextTheme(
  headline1: TextStyle(
      color: ThemeColors.primaryTextColor,
      fontSize: SizeConstant.font14,
      fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ThemeColors.titleColor, fontSize: SizeConstant.font16, fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ThemeColors.primaryTextColor,
    fontSize: SizeConstant.font14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color: ThemeColors.backgroundColor,
      fontSize: SizeConstant.font16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ThemeColors.hintColor, fontSize: SizeConstant.font16, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: SizeConstant.font12, color: TaskColors.lightBlackColor),
  subtitle1: TextStyle(
      color: ThemeColors.primaryTextColor,
      fontSize: SizeConstant.font18,
      fontWeight: FontWeight.w400),
  subtitle2: TextStyle(fontSize: SizeConstant.font17),
  headlineLarge: TextStyle(
      color: ThemeColors.dIconColor, fontSize: SizeConstant.font25, fontWeight: FontWeight.w400),
  bodyText1: TextStyle(fontSize: SizeConstant.font16, color: TaskColors.backgroundColor),
  bodyText2: TextStyle(
      color: TaskColors.blackColor, fontSize: SizeConstant.font16, fontWeight: FontWeight.w400),
);

TextTheme shadeTextThemeDark = const TextTheme(
  headline1: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: SizeConstant.font14,
      fontWeight: FontWeight.w400),
  headline2: TextStyle(
      color: ThemeColors.dTitleColor,
      fontSize: SizeConstant.font16,
      fontWeight: FontWeight.w400),
  headline3: TextStyle(
    color: ThemeColors.dBackgroundColor,
    fontSize: SizeConstant.font14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  headline4: TextStyle(
      color: ThemeColors.dPrimaryTextColor,
      fontSize: SizeConstant.font16,
      fontWeight: FontWeight.w400),
  headline5: TextStyle(
      color: ThemeColors.dHintColor, fontSize: SizeConstant.font16, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: SizeConstant.font12, color: TaskColors.backgroundColor),
  headlineLarge: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: SizeConstant.font25,
      fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      color: ThemeColors.dBackgroundColor,
      fontSize: SizeConstant.font18,
      fontWeight: FontWeight.w400),
  subtitle2: TextStyle(fontSize: SizeConstant.font17,),
  bodyText1: TextStyle(fontSize: SizeConstant.font16, color: TaskColors.backgroundColor),
  bodyText2: TextStyle(
      color: TaskColors.backgroundColor,
      fontSize: SizeConstant.font17,
      fontWeight: FontWeight.w400),
);
