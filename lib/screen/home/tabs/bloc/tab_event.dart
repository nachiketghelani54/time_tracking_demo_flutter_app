part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

///FetchTabEvent
class FetchTabEvent extends TabEvent {
  const FetchTabEvent(this.selectedTab);

  final int selectedTab;

  @override
  List<Object> get props => [];
}

///ChangeTabEvent
class ChangeTabEvent extends TabEvent {
  const ChangeTabEvent(this.selectedTab);

  final int selectedTab;

  @override
  List<Object> get props => [selectedTab];
}

///ClearDataEvent
class ClearDataEvent extends TabEvent {
  const ClearDataEvent(this.selectedTab);

  final int selectedTab;

  @override
  List<Object> get props => [selectedTab];
}
