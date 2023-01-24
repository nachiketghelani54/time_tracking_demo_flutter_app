part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState(this.taskList, this.listOfCsvList);

  final List<TaskModel>? taskList;
  final List<List<String>>? listOfCsvList;

  @override
  List<Object?> get props => [taskList, listOfCsvList];
}

///HistoryInitial
class HistoryInitial extends HistoryState {
  const HistoryInitial() : super(null, null);

  @override
  List<Object> get props => [];
}

///HistorySuccess
class HistorySuccess extends HistoryState {
  const HistorySuccess(
      {List<TaskModel>? taskList, List<List<String>>? listOfCsvList})
      : super(taskList, listOfCsvList);

  @override
  List<Object?> get props => [taskList, listOfCsvList];
}
