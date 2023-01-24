import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.firebaseConstant})
      : super(const HistoryInitial()) {
    on<FetchHistoryEvent>(_fetchHistoryToState);
  }

  final FirebaseConstant firebaseConstant;
  List<List<String>> listOfCsvLists = [];
  List<String> csvData = [];

  Future<void> _fetchHistoryToState(
    FetchHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final task = await firebaseConstant.taskDone;
    listOfCsvLists.clear();
    settingUpDataForCsv(task);
    emit(HistorySuccess(taskList: task, listOfCsvList: listOfCsvLists));
  }

  settingUpDataForCsv(List<TaskModel> task) {
    for (var i = 0; i < task.length; i++) {
      listOfCsvLists.add([
        task[i].dateTime.toString(),
        task[i].description.toString(),
        task[i].status.toString(),
        task[i].timeHistory.toString(),
        task[i].title.toString(),
        task[i].userId.toString(),
      ]);
    }
  }
}
