import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

import '../main.dart';

late SharedPreferences prefs;

initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
}

SharedPref sharedPref = sl<SharedPref>();

class SharedPref {

  ///Save Add Task Offline
  Future<void> addAllTask(List<TaskModel> model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(
        StringConstant.allTask, TaskModel.encode(model));
  }

  ///Fetch Add Task Offline
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

  ///Save New Task Offline
  Future<void> setNewTaskOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.newTask, jsonEncode(data));
  }

  ///Fetch New Task Offline
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

  ///Save Edit Task Offline
  Future<void> setEditTaskOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.editTask, jsonEncode(data));
  }

  ///Fetch Edit Task Offline
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

  ///Save Status offline
  Future<void> setStatusOffline(List data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(StringConstant.editStatus, jsonEncode(data));
  }

  ///Fetch Status offline
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
