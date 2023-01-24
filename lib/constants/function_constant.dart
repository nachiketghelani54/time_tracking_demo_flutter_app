import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';

///getColor Function
Color getColor(String task) {
  if (StringConstant.inProgressString == task) {
    return TaskColors.redColor;
  } else if (StringConstant.doneString == task) {
    return TaskColors.greenColor;
  } else {
    return TaskColors.yellowColor;
  }
}

///getTask Function
String getTask(int task) {
  if (task == 1) {
    return StringConstant.inProgressString;
  } else if (task == 2) {
    return StringConstant.doneString;
  } else {
    return StringConstant.todoString;
  }
}

///getTaskString Function
String getTaskString(int task) {
  if (task == 1) {
    return StringConstant.inProgressDataString;
  } else if (task == 2) {
    return StringConstant.doneDataString;
  } else {
    return StringConstant.todoDataString;
  }
}

///Duration Function
Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}
