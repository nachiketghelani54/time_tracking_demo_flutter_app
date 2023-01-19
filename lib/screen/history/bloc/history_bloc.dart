
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.firebaseConstant}) : super(const HistoryInitial()) {
    on<FetchHistoryEvent>(_fetchHistoryToState);
  }
  final FirebaseConstant firebaseConstant;

  Future<void> _fetchHistoryToState(
      FetchHistoryEvent event,
      Emitter<HistoryState> emit,
      ) async {
    final task = await firebaseConstant.task;
    emit(HistorySuccess(taskList: task));
  }
}
