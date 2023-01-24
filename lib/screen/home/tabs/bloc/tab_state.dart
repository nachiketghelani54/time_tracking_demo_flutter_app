part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
   TabState(this.taskList,this.selectedTab);

  final  List<TaskModel>? taskList;
  int? selectedTab;

  @override
  List<Object?> get props => [taskList,selectedTab];
}

///TabLoadingState
class TabLoadingState extends TabState {
   TabLoadingState() : super(null, null);

  @override
  List<Object> get props => [];
}

///TabSuccess
class TabSuccess extends TabState {
   TabSuccess({List<TaskModel>? taskList,required int selectTab})
      : super(taskList,selectTab);

  @override
  List<Object?> get props => [taskList,selectedTab];
}