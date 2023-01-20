part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchHistoryEvent extends HistoryEvent {
  const FetchHistoryEvent();

  //final DocumentReference task;

  @override
  List<Object> get props => [];
}


