import 'package:flutter/material.dart';

import 'color_constant.dart';

class FontStyleText {
  static TextStyle text14W400LightBlack = const TextStyle(
      color: TaskColors.lightBlackColor,
      fontSize: 14,
      fontWeight: FontWeight.w400);
  static TextStyle text14W400Hint = const TextStyle(
      color: TaskColors.hintColor, fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle text14W500Green = const TextStyle(
      fontWeight: FontWeight.w500,
      color: TaskColors.greenCompletedColor,
      fontSize: 14);
  static TextStyle text22W500White = const TextStyle(
      fontWeight: FontWeight.w500,
      color: TaskColors.backgroundColor,
      fontSize: 22);
}
