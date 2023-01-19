import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';

Color getColor(String task) {
  if (StringConstant.inProgressString == task) {
    return TaskColors.redColor;
  } else if (StringConstant.doneString == task) {
    return TaskColors.greenColor;
  } else {
    return TaskColors.yellowColor;
  }
}
