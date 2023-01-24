import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';

import '../main.dart';
import '../models/task_model.dart';

SharedPref sharedPref = sl<SharedPref>();

class SharedPref {
  Future<void> addAllTask(List<TaskModel> model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(
        StringConstant.allTask, TaskModel.encode(model));
  }

  Future<List<TaskModel>?> get getAllTask async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var data = sharedPreferences.getString(StringConstant.allTask);
    if (data != null) {
      List<TaskModel> list = TaskModel.decode(data);
      return list;
    } else {
      return null;
    }
  }

  Future<void> setNewTaskOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.newTask, jsonEncode(data));
  }

  Future<List?> get getNewTaskOffline async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(StringConstant.newTask);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> setEditTaskOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.editTask, jsonEncode(data));
  }

  Future<List?> get getEditTaskOffline async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(StringConstant.editTask);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> setStatusOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.editStatus, jsonEncode(data));
  }

  Future<List?> get getStatusOffline async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(StringConstant.editStatus);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> setStartOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.startTime, jsonEncode(data));
  }

  Future<List?> get getStartOffline async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(StringConstant.startTime);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> setEndOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.endTime, jsonEncode(data));
  }

  Future<List?> get getEndOffline async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(StringConstant.endTime);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }
}
