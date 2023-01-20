part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
   TabState(this.taskList,this.selectedTab);

  final  List<TaskModel>? taskList;
  int? selectedTab;

  @override
  List<Object?> get props => [taskList,selectedTab];
}

class TabLoadingState extends TabState {
   TabLoadingState() : super(null, null);

  @override
  List<Object> get props => [];
}

// class TabInital extends TabState {
//     TabInital() : super(null, 0) ;
//
//   @override
//   List<Object> get props => [];
// }

class TabSuccess extends TabState {
   TabSuccess({List<TaskModel>? taskList,required int selectTab})
      : super(taskList,selectTab);

  @override
  List<Object?> get props => [taskList,selectedTab];
}