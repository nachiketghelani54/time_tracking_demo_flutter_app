part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

///FetchHistoryEvent
class FetchHistoryEvent extends HistoryEvent {
  const FetchHistoryEvent();

  @override
  List<Object> get props => [];
}
