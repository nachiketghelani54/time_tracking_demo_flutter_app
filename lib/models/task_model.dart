

class TaskModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  DateTime? dateTime;
  List<String>? timeHistory;

  TaskModel({
    this.id = '',
    this.userId = '',
    this.title = '',
    this.description = '',
    this.dateTime,
    this.timeHistory = const [],
  });

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dateTime,
    List<String>? timeHistory,
  }) =>
      TaskModel(
        id: id ?? this.id,
        userId: userId ?? userId,
        title: title ?? title,
        description: description ?? this.description,
        dateTime: dateTime ?? dateTime,
        timeHistory: timeHistory ?? this.timeHistory,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'userId': userId});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'dateTime': dateTime ?? DateTime.now()});
    result.addAll({'timeHistory': timeHistory});
    return result;
  }

  factory TaskModel.fromMap(String id,Map<String, dynamic> map) {
    return TaskModel(
      id: id ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(
          map['dateTime'].millisecondsSinceEpoch),
      timeHistory: map['timeHistory'] == [] ? [] : List<String>.from(map['timeHistory']),
    );
  }
}
