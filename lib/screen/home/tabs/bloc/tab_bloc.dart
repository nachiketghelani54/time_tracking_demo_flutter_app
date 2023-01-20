
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super( TabLoadingState()) {
    on<FetchTabEvent>(_fetchHistoryToState);
    on<ChangeTabEvent>(_changeLocaleEventToState);
  }


  Future<void> _fetchHistoryToState(
      FetchTabEvent event,
      Emitter<TabState> emit,
      ) async {
    final task = await FirebaseConstant.task1(event.selectedTab);
    

    
    emit(TabSuccess(taskList: task,selectTab: event.selectedTab));
  }

  Future<void> _changeLocaleEventToState(
      ChangeTabEvent event,
      Emitter<TabState> emit,
      ) async {
    try {
      final task = await FirebaseConstant.task1(event.selectedTab);

      emit(TabSuccess(taskList:task,selectTab: event.selectedTab));
    } catch (e) {

    }
  }

}
