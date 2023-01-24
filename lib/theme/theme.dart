import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/theme/widget_theme/app_bar_theme.dart';
import 'package:time_tracking_demo/theme/widget_theme/colors_and_text_style.dart';
import 'package:time_tracking_demo/theme/widget_theme/shade_elevated_button_theme.dart';
import 'package:time_tracking_demo/theme/widget_theme/shade_text_theme.dart';

import '../constants/string_constant.dart';

class TaskTheme {
  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();
  static final ThemeData redTheme = _buildRedTheme();
  static final ThemeData greenTheme = _buildGreenTheme();
  static final ThemeData orangeTheme = _buildOrangeTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ThemeColors.primaryColor,
      backgroundColor: ThemeColors.backgroundColor,
      cardColor: ThemeColors.backgroundColor,
      iconTheme: const IconThemeData(color: ThemeColors.iconColor),
      appBarTheme: appBarThemeLight,
      bottomAppBarColor: ThemeColors.backgroundColor,
      textTheme: shadeTextThemeLight,
      shadowColor: ThemeColors.hintColor,
      indicatorColor: ThemeColors.primaryColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: TaskColors.darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.buttonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      hintColor: Colors.grey,
      brightness: Brightness.dark,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ThemeColors.dPrimaryColor,
      backgroundColor: ThemeColors.dPrimaryColor,
      cardColor: ThemeColors.dCardColor,
      indicatorColor: TaskColors.backgroundColor,
      iconTheme: const IconThemeData(color: ThemeColors.dIconColor),
      appBarTheme: const AppBarTheme(backgroundColor: TaskColors.darkColor),
      bottomAppBarColor: TaskColors.darkColor,
      textTheme: shadeTextThemeDark,
      shadowColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: ThemeColors.dBackgroundColor,
      ),
      buttonTheme:
          const ButtonThemeData(buttonColor: ThemeColors.darkButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildRedTheme() {
    return ThemeData(
      brightness: Brightness.light,
      indicatorColor: ThemeColors.rPrimaryColor,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ThemeColors.rPrimaryColor,
      backgroundColor: ThemeColors.rBackgroundColor,
      cardColor: ThemeColors.rCardColor,
      iconTheme: const IconThemeData(color: ThemeColors.rIconColor),
      appBarTheme: appBarThemeLight,
      bottomAppBarColor: ThemeColors.rBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: TaskColors.darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.rButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildGreenTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      indicatorColor: ThemeColors.gPrimaryColor,
      primaryColor: ThemeColors.gPrimaryColor,
      backgroundColor: ThemeColors.gBackgroundColor,
      cardColor: ThemeColors.gCardColor,
      iconTheme: const IconThemeData(color: ThemeColors.gIconColor),
      appBarTheme: appBarThemeLight,
      bottomAppBarColor: ThemeColors.gBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: TaskColors.darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.gButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildOrangeTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      indicatorColor: ThemeColors.oPrimaryColor,
      primaryColor: ThemeColors.oPrimaryColor,
      backgroundColor: ThemeColors.oBackgroundColor,
      cardColor: ThemeColors.oCardColor,
      iconTheme: const IconThemeData(color: ThemeColors.oIconColor),
      appBarTheme: appBarThemeLight,
      bottomAppBarColor: ThemeColors.oBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: TaskColors.darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.oButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }
}
