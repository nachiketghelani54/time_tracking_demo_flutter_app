import 'dart:convert';

import 'package:time_tracking_demo/constants/function_constant.dart';

class TaskModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? status;
  DateTime? dateTime;
  Duration? totalOfDuration;
  List<String>? timeHistory;
  List<String>? startTime;
  List<String>? endTime;
  bool? isStart;

  TaskModel({
    this.id = '',
    this.userId = '',
    this.title = '',
    this.description = '',
    this.status = '',
    this.dateTime,
    this.totalOfDuration,
    this.timeHistory = const [],
    this.startTime = const [],
    this.endTime = const [],
    this.isStart,
  });

  TaskModel copyWith(
          {String? id,
          String? userId,
          String? title,
          String? description,
          String? status,
          DateTime? dateTime,
          Duration? totalOfDuration,
          List<String>? timeHistory,
          List<String>? startTime,
          List<String>? endTime,
          bool? isStart}) =>
      TaskModel(
          id: id ?? this.id,
          userId: userId ?? userId,
          title: title ?? title,
          description: description ?? this.description,
          status: status ?? this.status,
          dateTime: dateTime ?? dateTime,
          totalOfDuration: totalOfDuration ?? totalOfDuration,
          timeHistory: timeHistory ?? this.timeHistory,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          isStart: isStart ?? this.isStart);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'userId': userId});
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'status': status});
    result.addAll({'dateTime': dateTime ?? DateTime.now()});
    result.addAll({'totalOfDuration': totalOfDuration ?? Duration()});
    result.addAll({'timeHistory': timeHistory});
    result.addAll({'startTime': startTime});
    result.addAll({'endTime': endTime});
    result.addAll({'isStart': isStart});
    return result;
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
        id: map["id"] ?? "",
        userId: map['userId'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        status: map['status'] ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            map['dateTime'].millisecondsSinceEpoch),
        totalOfDuration: parseDuration(map['totalOfDuration']),
        timeHistory: map['timeHistory'] == []
            ? []
            : List<String>.from(map['timeHistory']),
        startTime:
            map['startTime'] == [] ? [] : List<String>.from(map['startTime']),
        endTime: map['endTime'] == [] ? [] : List<String>.from(map['endTime']),
        isStart: map['isStart'] ?? false);
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      dateTime: DateTime.parse(json['dateTime']),
      totalOfDuration: parseDuration(json['totalOfDuration']),
      timeHistory: json['timeHistory'] == []
          ? []
          : List<String>.from(json['timeHistory']),
      startTime:
          json['startTime'] == [] ? [] : List<String>.from(json['startTime']),
      endTime: json['endTime'] == [] ? [] : List<String>.from(json['endTime']),
      isStart: json['isStart'] ?? false);

  static Map<String, dynamic> taskModelToMap(TaskModel taskModel) => {
        'userId': taskModel.userId,
        "id": taskModel.id,
        'title': taskModel.title,
        'description': taskModel.description,
        'status': taskModel.status,
        'dateTime': taskModel.dateTime.toString(),
        'totalOfDuration': taskModel.totalOfDuration.toString(),
        'timeHistory': taskModel.timeHistory,
        'startTime': taskModel.startTime,
        'endTime': taskModel.endTime,
        'isStart': taskModel.isStart,
      };

  static String encode(List<TaskModel> taskModel) => json.encode(
        taskModel
            .map<Map<String, dynamic>>((task) => TaskModel.taskModelToMap(task))
            .toList(),
      );

  static List<TaskModel> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<TaskModel>((item) => TaskModel.fromJson(item))
          .toList();
}
