import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracking_demo/constants/shared_preferences.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

import 'function_constant.dart';

class FirebaseConstant {
  static final FirebaseFirestore _fireStoreData = FirebaseFirestore.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static setCollection({required String collectionName, required Map<String, dynamic> value,required String id}) {
    return _fireStoreData.collection(collectionName ?? '').doc(id).set(value);
  }

  static Future updateCollection({required String collectionName, required Map<String, dynamic> value, required String docId}) {
    return _fireStoreData.collection(collectionName ?? '').doc(docId).update(value);
  }

  /// Get task from [Collection]
  Future<List<TaskModel>> get taskDone async {
    try {
      if (await ConnectivityWrapper.instance.isConnected) {
        QuerySnapshot<Map<String, dynamic>> taskList = await _fireStoreData
            .collection(StringConstant.taskCollection)
            .get();
        return taskList.docs
            .toList()
            .map((e) => TaskModel.fromMap(e.id, e.data()))
            .where((element) => element.status == StringConstant.doneString)
            .toList();
      } else {
        List<TaskModel> taskList = [];
        List<TaskModel> offlineData = await sharedPref.getAllTask ?? [];
        taskList.addAll(offlineData
            .where((element) => element.status == StringConstant.doneString));
        return taskList;
      }
    } catch (e) {
      return [];
    }
  }

  /// Get task from [Collection]
  Future<List<TaskModel>> get allTask async {
    try {
      QuerySnapshot<Map<String, dynamic>> task = await _fireStoreData.collection(StringConstant.taskCollection).get();
      return task.docs.toList().map((e) => TaskModel.fromMap(e.id, e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get task from [Collection]
  static Future<List<TaskModel>> taskTab({required int pageIndex}) async {
    try {
      if (await ConnectivityWrapper.instance.isConnected) {
        QuerySnapshot<Map<String, dynamic>> task = await _fireStoreData
            .collection(StringConstant.taskCollection)
            .get();
        List<TaskModel> taskList = task.docs
            .toList()
            .map((e) => TaskModel.fromMap(e.id, e.data()))
            .toList();
        List<TaskModel> filterTaskList = [];
        filterTaskList
            .addAll(taskList.where((element) => element.status == getTask(pageIndex)));
        return filterTaskList;
      } else {
        List<TaskModel> taskOffline = [];
        List<TaskModel> offlineData = await sharedPref.getAllTask ?? [];
        taskOffline.addAll(
            offlineData.where((element) => element.status == getTask(pageIndex)));
        return taskOffline;
      }
    } catch (e) {
      return [];
    }
  }

  /// Get userId from [Collection]
  Future<String> get userId async {
    try {
      UserCredential users = await _auth.signInAnonymously();
      if (users.user != null) {
        return users.user?.uid.toString() ?? '';
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static fetchHomeTaskData(){
    _setDataToStorage();
    ConnectivityWrapper.instance.onStatusChange.listen((event) async {
      if (event == ConnectivityStatus.CONNECTED) {
        _setDataToStorage();

        List data = await sharedPref.getNewTaskOffline ?? [];
        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            await FirebaseConstant.setCollection(
                collectionName: StringConstant.taskCollection,
                value: {
                  "id": data[i]["id"].toString(),
                  'userId': data[i]["userId"],
                  'title': data[i]["title"],
                  'description': data[i]["description"],
                  'dateTime': DateTime.parse(data[i]["dateTime"]),
                  'timeHistory': data[i]["timeHistory"],
                  'status': data[i]["status"],
                  'startTime': data[i]["startTime"],
                  'endTime': data[i]["endTime"],
                  'isPlay': data[i]["isPlay"],
                  'totalOfDuration': data[i]["totalOfDuration"]
                },
                id: data[i]["id"].toString());
            data.removeAt(i);
          }
          await sharedPref.setNewTaskOffline(data);
        }

        List dataForEdit = [];
        dataForEdit = await sharedPref.getEditTaskOffline ?? [];
        if (dataForEdit.isNotEmpty) {
          for (var i = 0; i < dataForEdit.length; i++) {
            if (dataForEdit[i]["docId"] != "") {
              await FirebaseConstant.updateCollection(
                  docId: dataForEdit[i]["docId"] ?? '',
                  collectionName: StringConstant.taskCollection,
                  value: {
                    'title': dataForEdit[i]["title"],
                    'description': dataForEdit[i]["description"],
                  });
            }
          }
          await sharedPref.setEditTaskOffline([]);
        }
        List dataForEditStatus = [];
        dataForEditStatus = await sharedPref.getStatusOffline ?? [];
        if (dataForEditStatus.isNotEmpty) {
          for (var i = 0; i < dataForEditStatus.length; i++) {
            await FirebaseConstant.updateCollection(
                docId: dataForEditStatus[i]["docId"] ?? '',
                collectionName: StringConstant.taskCollection,
                value: {
                  'status': dataForEditStatus[i]["status"],
                });
          }
          await sharedPref.setStatusOffline([]);
        }
        List dataStart = [];
        dataStart = await sharedPref
            .getStartOffline ?? [];
        if (dataStart.isNotEmpty) {
          for (var i = 0; i < dataStart.length; i++) {
            await FirebaseConstant.updateCollection(
                docId: dataStart[i]["docId"] ?? '',
                collectionName: StringConstant.taskCollection,
                value: {
                  'startTime': dataStart[i]["startTime"],
                  'isStart': dataStart[i]["isStart"],
                  "status" : dataStart[i]["status"]
                });
          }
          await sharedPref.setStartOffline([]);
          List dataEnd = [];
          dataEnd = await sharedPref.getEndOffline ?? [];
          if (dataEnd.isNotEmpty) {
            for (var i = 0; i < dataEnd.length; i++) {
              await FirebaseConstant.updateCollection(
                  docId: dataEnd[i]["docId"] ?? '',
                  collectionName: StringConstant.taskCollection,
                  value: {
                    'timeHistory': dataEnd[i]["timeHistory"],
                    'endTime': dataEnd[i]["endTime"],
                    'isStart': dataEnd[i]["isStart"],
                    'totalOfDuration': dataEnd[i]["totalOfDuration"]
                  });
            }
            await sharedPref.setEndOffline([]);
          }
          _setDataToStorage();
        }
      }
    });
  }
  static _setDataToStorage() async {
    FirebaseConstant firebaseConstant = FirebaseConstant();
    if (await ConnectivityWrapper.instance.isConnected) {
      await sharedPref.addAllTask(await firebaseConstant.allTask);
    }
  }
}
