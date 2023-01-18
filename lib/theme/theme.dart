import 'package:flutter/material.dart';
import 'package:time_tracking_demo/theme/widget_theme/app_bar_theme.dart';
import 'package:time_tracking_demo/theme/widget_theme/colors_and_text_style.dart';
import 'package:time_tracking_demo/theme/widget_theme/shade_elevated_button_theme.dart';
import 'package:time_tracking_demo/theme/widget_theme/shade_text_theme.dart';

import '../constants/string_constant.dart';

class TaskTheme {
  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ShadeColors.primaryColor,
      backgroundColor: ShadeColors.backgroundColor,
      cardColor: ShadeColors.cardColor,
      iconTheme: const IconThemeData(color: ShadeColors.cardColor),
      appBarTheme: shadeAppBarThemeLight,
      bottomAppBarColor: mainBackGroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ShadeColors.buttonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: StringConstant.fontFamily,
      primaryColor: mainBackGroundColor,
      backgroundColor: mainBackGroundBlackColor,
      cardColor: mainBackGroundColor,
      iconTheme: const IconThemeData(color: ShadeColors.primaryColor),
      appBarTheme: AppBarTheme(backgroundColor: darkColor),
      bottomAppBarColor: darkColor,
      textTheme: shadeTextThemeDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: mainBackGroundColor,
      ),
      buttonTheme:
          const ButtonThemeData(buttonColor: ShadeColors.darkButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }
}
