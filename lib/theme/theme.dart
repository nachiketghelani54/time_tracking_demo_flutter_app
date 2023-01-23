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
      primaryColor: ShadeColors.primaryColor,
      backgroundColor: ShadeColors.backgroundColor,
      cardColor: ShadeColors.backgroundColor,
      iconTheme: const IconThemeData(color: ShadeColors.iconColor),
      appBarTheme: shadeAppBarThemeLight,
      bottomAppBarColor: ShadeColors.backgroundColor,
      textTheme: shadeTextThemeLight,
      shadowColor: ShadeColors.hintColor,
      indicatorColor: ShadeColors.primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ShadeColors.buttonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      hintColor: Colors.grey,
      brightness: Brightness.dark,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ShadeColors.dPrimaryColor,
      backgroundColor: ShadeColors.dPrimaryColor,
      cardColor: ShadeColors.dCardColor,
      indicatorColor: TaskColors.backgroundColor,
      iconTheme: const IconThemeData(color: ShadeColors.dIconColor),
      appBarTheme: AppBarTheme(backgroundColor: darkColor),
      bottomAppBarColor: darkColor,
      textTheme: shadeTextThemeDark,
      shadowColor: Colors.black,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ShadeColors.dBackgroundColor,
      ),
      buttonTheme:
          const ButtonThemeData(buttonColor: ShadeColors.darkButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildRedTheme() {
    return ThemeData(
      brightness: Brightness.light,
      indicatorColor: ShadeColors.rPrimaryColor,
      fontFamily: StringConstant.fontFamily,
      primaryColor: ShadeColors.rPrimaryColor,
      backgroundColor: ShadeColors.rBackgroundColor,
      cardColor: ShadeColors.rCardColor,
      iconTheme: const IconThemeData(color: ShadeColors.rIconColor),
      appBarTheme: shadeAppBarThemeLight,
      bottomAppBarColor: ShadeColors.rBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ShadeColors.rButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildGreenTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      indicatorColor: ShadeColors.gPrimaryColor,
      primaryColor: ShadeColors.gPrimaryColor,
      backgroundColor: ShadeColors.gBackgroundColor,
      cardColor: ShadeColors.gCardColor,
      iconTheme: const IconThemeData(color: ShadeColors.gIconColor),
      appBarTheme: shadeAppBarThemeLight,
      bottomAppBarColor: ShadeColors.gBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ShadeColors.gButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }

  static ThemeData _buildOrangeTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstant.fontFamily,
      indicatorColor: ShadeColors.oPrimaryColor,
      primaryColor: ShadeColors.oPrimaryColor,
      backgroundColor: ShadeColors.oBackgroundColor,
      cardColor: ShadeColors.oCardColor,
      iconTheme: const IconThemeData(color: ShadeColors.oIconColor),
      appBarTheme: shadeAppBarThemeLight,
      bottomAppBarColor: ShadeColors.oBackgroundColor,
      textTheme: shadeTextThemeLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkIconColor2,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: ShadeColors.oButtonColor),
      elevatedButtonTheme: shadeElevatedButtonTheme,
    );
  }
}
