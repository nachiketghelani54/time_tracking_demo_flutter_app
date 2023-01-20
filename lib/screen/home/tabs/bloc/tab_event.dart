part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

class FetchTabEvent extends TabEvent {
    FetchTabEvent(this.selectedTab);
   //  List<TaskModel> taskList = [];
  final int selectedTab;

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends TabEvent {
 // final List<TaskModel> taskList;
   ChangeTabEvent(this.selectedTab);
   // List<TaskModel> taskList = [];
  final int selectedTab;

  @override
  List<Object> get props => [selectedTab];
}
