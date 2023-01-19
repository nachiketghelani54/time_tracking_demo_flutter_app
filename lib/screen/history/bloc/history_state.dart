part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState(this.taskList);

  final  List<TaskModel>? taskList;

  @override
  List<Object?> get props => [taskList];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial() : super(null);

  @override
  List<Object> get props => [];
}

class HistorySuccess extends HistoryState {
  const HistorySuccess({List<TaskModel>? taskList})
      : super(taskList);

  @override
  List<Object?> get props => [taskList];
}