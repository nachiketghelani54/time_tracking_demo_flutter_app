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
    final task = await firebaseConstant.task;
    settingUpDataForCsv(task);
    emit(HistorySuccess(taskList: task, listOfCsvList: listOfCsvLists));
  }

  settingUpDataForCsv(task) {
    for (var i = 0; i < task!.length; i++) {
      csvData.clear();
      csvData.add(
        task![i].dateTime.toString(),
      );
      csvData.add(
        task![i].description.toString(),
      );
      csvData.add(
        task![i].status.toString(),
      );
      csvData.add(
        task![i].timeHistory.toString(),
      );
      csvData.add(
        task![i].title.toString(),
      );
      csvData.add(
        task![i].userId.toString(),
      );
      listOfCsvLists.add(csvData);
    }
  }
}
