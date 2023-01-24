import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabLoadingState()) {
    on<FetchTabEvent>(_fetchTabToState);
    on<ChangeTabEvent>(_changeLocaleEventToState);
    on<ClearDataEvent>(_clearData);
  }

  ///Fetch Tab Index Details
  Future<void> _fetchTabToState(
    FetchTabEvent event,
    Emitter<TabState> emit,
  ) async {
    final task = await FirebaseConstant.taskTab(pageIndex: event.selectedTab);

    emit(TabSuccess(taskList: task, selectTab: event.selectedTab));
  }

  ///Clear Tab Data
  Future<void> _clearData(
    ClearDataEvent event,
    Emitter<TabState> emit,
  ) async {
    List<TaskModel> task = [];

    emit(TabSuccess(taskList: task, selectTab: event.selectedTab));
  }

  ///Change Locale Tab Task
  Future<void> _changeLocaleEventToState(
    ChangeTabEvent event,
    Emitter<TabState> emit,
  ) async {
    final task = await FirebaseConstant.taskTab(pageIndex: event.selectedTab);

    emit(TabSuccess(taskList: task, selectTab: event.selectedTab));
  }
}
