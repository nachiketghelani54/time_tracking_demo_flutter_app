

import 'package:time_tracking_demo/constants/function.dart';

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

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? status,
    DateTime? dateTime,
    Duration? totalOfDuration,

    List<String>? timeHistory,
    List<String>? startTime,
    List<String>? endTime,
    bool? isStart

  }) =>
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
        isStart: isStart ?? this.isStart
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'userId': userId});
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

  factory TaskModel.fromMap(String id,Map<String, dynamic> map) {
    return TaskModel(
      id: id ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(
          map['dateTime'].millisecondsSinceEpoch),
        totalOfDuration: parseDuration(map['totalOfDuration']) ?? Duration(),
      timeHistory: map['timeHistory'] == [] ? [] : List<String>.from(map['timeHistory']),
      startTime: map['startTime'] == [] ? [] : List<String>.from(map['startTime']),
      endTime: map['endTime'] == [] ? [] : List<String>.from(map['endTime']),
      isStart: map['isStart'] ?? false
    );
  }
}
