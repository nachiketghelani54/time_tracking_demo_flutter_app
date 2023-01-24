import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/models/task_model.dart';
import 'package:time_tracking_demo/screen/add_new_task/add_new_task_screen.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';

import '../../../constants/firebase_constant.dart';
import '../../../constants/function_constant.dart';
import '../../../constants/notification_helper.dart';
import '../../../constants/shared_preferences.dart';
import '../../../constants/string_constant.dart';
import '../../bottom_nav/bottom_nav_bar.dart';

class TaskScreen extends StatefulWidget {
  int index;

  TaskScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TabBloc _tabBloc = TabBloc();
  List<TaskModel> task = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return _tabBloc..add(FetchTabEvent(widget.index));
        },
        child: BlocConsumer<TabBloc, TabState>(
          listener: (context, state) {
            if (state is TabSuccess) {
              task = state.taskList ?? [];
            }
          },
          builder: (context, state) {
            return BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                if (state is TabLoadingState) {
                  return _loader();
                } else if (state is TabSuccess) {
                  return task.isEmpty
                      ? Center(
                    child: Text(getTaskString(widget.index,context)),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ListView.builder(
                      itemCount: task.length,
                      itemBuilder: (context, index) {
                        return _taskElement(index);
                      },
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return state.selectedTab != 0 ? Container() : flotAction();
        },
      ),
    );
  }

  /// loader
  Widget _loader() {
    return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ));
  }

  ///TaskElement Common Widget
  Widget _taskElement(int index) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Row(
          children: [
            Container(
              height: 140,
              width: 8,
              decoration: BoxDecoration(
                color: getColor(task[index].status ?? ''),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
            ),
            Expanded(
              child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(6),
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(3),
                          topLeft: Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: const Offset(0, 4),
                            blurRadius: 10)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          task[index].title ?? "",
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          task[index].description ?? "",
                          style: Theme.of(context).textTheme.headline5,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Container(
                          decoration: const BoxDecoration(),
                          child: PopupMenuButton(
                            constraints: const BoxConstraints(maxWidth: 130),
                            offset: const Offset(110, 0),
                            color: Theme.of(context).backgroundColor,
                            child: Icon(
                              Icons.more_vert,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            itemBuilder: (ctx) => [
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    editTaskNav(index);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/edit.png",
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        context.localization.edit,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: PopupMenuButton(
                                    constraints:
                                    const BoxConstraints(maxWidth: 130),
                                    offset: const Offset(110, 0),
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/move.png",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          context.localization.move,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                    itemBuilder: (ctx) {
                                      if (widget.index == 0) {
                                        return [
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () async {
                                                inProgressButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      context.localization
                                                          .in_progress,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                doneButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      context.localization.done,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ];
                                      } else if (widget.index == 1) {
                                        return [
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                todoButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      context
                                                          .localization.to_do,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                doneButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      context.localization.done,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ];
                                      } else {
                                        return [
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                todoButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    context.localization.to_do,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                inProgressButton(index);
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      context.localization
                                                          .in_progress,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ];
                                      }
                                    },
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                          color: Theme.of(context).hintColor,
                          endIndent: 8,
                          indent: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/ic_calander.png",
                                  scale: 1.8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    task[index]
                                        .dateTime
                                        .toString()
                                        .split(" ")
                                        .last
                                        .split(".")
                                        .first,
                                    style:
                                    Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/ic_clock.png",
                                  scale: 1.8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    task[index]
                                        .dateTime
                                        .toString()
                                        .split(" ")
                                        .first,
                                    style:
                                    Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap:  () async {
                                List<String> startTime = task[index].startTime!;
                                List<String> endTime = task[index].endTime!;
                                List<String> totalHistory = task[index].timeHistory!;
                                Duration? total;
                                if (task[index].isStart ?? false) {
                                  NotificationService().showNotification(
                                      UniqueKey().hashCode,
                                      task[index].title.toString(),
                                      "congratulations! You done the task.");
                                  endTime.add(DateTime.now().toString());
                                  totalHistory.add(DateTime.parse(endTime.last)
                                      .difference(startTime.isEmpty
                                      ? DateTime(2023)
                                      : DateTime.parse(startTime.last))
                                      .toString());
                                  for (int i = 0; i < task[index].timeHistory!.length; i++) {
                                    Duration dt = parseDuration(task[index].timeHistory![i]);
                                    total = total == null
                                        ? parseDuration(task[index].timeHistory![i])
                                        : total = Duration(
                                        days: total.inDays + dt.inDays,
                                        microseconds: total.inMicroseconds + dt.inMicroseconds,
                                        milliseconds: total.inMilliseconds + dt.inMilliseconds,
                                        minutes: total.inMinutes + dt.inMinutes,
                                        hours: total.inHours + dt.inHours,
                                        seconds: total.inSeconds + dt.inSeconds);
                                  }
                                  if (await ConnectivityWrapper.instance.isConnected) {
                                    await FirebaseConstant.updateCollection(
                                        docId: task[index].id ?? '',
                                        collectionName: StringConstant.taskCollection,
                                        value: {
                                          'timeHistory': totalHistory,
                                          'endTime': endTime,
                                          'isStart': false,
                                          'totalOfDuration': total.toString()
                                        });
                                    navigation(i: widget.index);
                                    tabUpdate();
                                  } else {
                                    List data = [];
                                    data = await sharedPref.getEditTaskOffline ?? [];
                                    data.add({
                                      "docId": task[index].id ?? '',
                                      'timeHistory': totalHistory,
                                      'endTime': endTime,
                                      'isStart': false,
                                      'totalOfDuration': total.toString()
                                    });
                                    await sharedPref.setEndOffline(data);
                                  }
                                  List<TaskModel> allTask =
                                  await sharedPref.getAllTask as List<TaskModel>;
                                  int indexNumber = allTask.indexWhere(
                                          (element) => element.id.toString() == task[index].id.toString());
                                  allTask[indexNumber] = TaskModel(
                                      id: allTask[indexNumber].id,
                                      status: allTask[indexNumber].status,
                                      title: allTask[indexNumber].title,
                                      dateTime: allTask[index].dateTime,
                                      description: allTask[indexNumber].description,
                                      endTime: allTask[index].endTime,
                                      isStart: false,
                                      startTime: allTask[index].startTime,
                                      timeHistory: allTask[index].timeHistory,
                                      totalOfDuration: allTask[index].totalOfDuration,
                                      userId: allTask[index].userId);
                                  await sharedPref.addAllTask(allTask).then((value) {
                                    navigation(i: widget.index);
                                    tabUpdate();
                                  });
                                } else {
                                  NotificationService().showNotification(UniqueKey().hashCode,
                                      task[index].title.toString(), "You started the task.");
                                  startTime.add(DateTime.now().toString());
                                  if (await ConnectivityWrapper.instance.isConnected) {
                                    await FirebaseConstant.updateCollection(
                                        docId: task[index].id ?? '',
                                        collectionName: StringConstant.taskCollection,
                                        value: {
                                          'startTime': startTime,
                                          'isStart': true,
                                          "status": task[index].status
                                        });
                                  } else {
                                    task[index].isStart = true;
                                    List data = [];

                                    data = await sharedPref.getStartOffline ?? [];
                                    data.add({
                                      "docId": task[index].id ?? '',
                                      "startTime": startTime,
                                      "isStart": true,
                                      "status": task[index].status
                                    });
                                    await sharedPref.setStartOffline(data);
                                    List<TaskModel> allTask =
                                    await sharedPref.getAllTask as List<TaskModel>;
                                    int indexNumber = allTask.indexWhere(
                                            (element) => element.id.toString() == task[index].id.toString());
                                    allTask[indexNumber] = TaskModel(
                                        id: allTask[indexNumber].id,
                                        status: allTask[indexNumber].status,
                                        title: allTask[indexNumber].title,
                                        dateTime: allTask[index].dateTime,
                                        description: allTask[indexNumber].description,
                                        endTime: allTask[index].endTime,
                                        isStart: true,
                                        startTime: allTask[index].startTime,
                                        timeHistory: allTask[index].timeHistory,
                                        totalOfDuration: allTask[index].totalOfDuration,
                                        userId: allTask[index].userId);
                                    await sharedPref.addAllTask(allTask).then((value) {
                                      navigation(i: widget.index);
                                      tabUpdate();
                                    });
                                  }
                                }
                                navigation(i: widget.index);
                                tabUpdate();
                              },
                              child: startStopButton(index),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }

  /// start and  Stop Button Common Widget
  Widget startStopButton(int index) {
    return Container(
      height: 35,
      width: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        task[index].isStart ?? false
            ? context.localization.stop
            : context.localization.start,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  /// tab Update function
  void tabUpdate({int? i}) {
    context.read<TabBloc>().add(ChangeTabEvent(i ?? widget.index));
  }

  /// Common Navigator for the Screen.
  void navigation({int? i}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavBarScreen(i ?? 0)),
            (Route<dynamic> route) => false);
  }

  Future<void> doneButton(int index) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      await FirebaseConstant.updateCollection(
          docId: task[index].id ?? "",
          collectionName: StringConstant.taskCollection,
          value: {"status": StringConstant.doneString}).then((value) {
        tabUpdate(i: 2);
        navigation(i: 2);
      });
    } else {
      List editStatus = await sharedPref.getEditTaskOffline ?? [];
      editStatus.add({
        "docId": task[index].id ?? "",
        "status": StringConstant.doneString,
      });
      sharedPref.setStatusOffline(editStatus);
      List<TaskModel> allTask = [];
      allTask = await sharedPref.getAllTask as List<TaskModel>;
      int indexData =
      allTask.indexWhere((element) => element.id == task[index].id);
      allTask[indexData] = TaskModel(
          id: allTask[indexData].id,
          status: StringConstant.doneString,
          title: allTask[indexData].title,
          dateTime: allTask[indexData].dateTime,
          description: allTask[indexData].description,
          endTime: allTask[indexData].endTime,
          isStart: allTask[indexData].isStart,
          startTime: allTask[indexData].startTime,
          timeHistory: allTask[indexData].timeHistory,
          totalOfDuration: allTask[indexData].totalOfDuration,
          userId: allTask[indexData].userId);
      await sharedPref.addAllTask(allTask);
      navigation(i: 2);
    }
  }

  Future<void> inProgressButton(int index) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      await FirebaseConstant.updateCollection(
          docId: task[index].id ?? "",
          collectionName: StringConstant.taskCollection,
          value: {"status": StringConstant.inProgressString}).then((value) {
        navigation(i: 1);
        tabUpdate(i: 1);
      });
    } else {
      List editStatus = await sharedPref.getEditTaskOffline ?? [];
      editStatus.add({
        "docId": task[index].id ?? "",
        "status": StringConstant.inProgressString,
      });
      sharedPref.setStatusOffline(editStatus);
      List<TaskModel> allTask = [];
      allTask = await sharedPref.getAllTask as List<TaskModel>;
      int indexData =
      allTask.indexWhere((element) => element.id == task[index].id);
      allTask[indexData] = TaskModel(
          id: allTask[indexData].id,
          status: StringConstant.inProgressString,
          title: allTask[indexData].title,
          dateTime: allTask[indexData].dateTime,
          description: allTask[indexData].description,
          endTime: allTask[indexData].endTime,
          isStart: allTask[indexData].isStart,
          startTime: allTask[indexData].startTime,
          timeHistory: allTask[indexData].timeHistory,
          totalOfDuration: allTask[indexData].totalOfDuration,
          userId: allTask[indexData].userId);
      await sharedPref.addAllTask(allTask);
      navigation(i: 1);
    }
  }

  Future<void> todoButton(int index) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      await FirebaseConstant.updateCollection(
          docId: task[index].id ?? "",
          collectionName: StringConstant.taskCollection,
          value: {"status": StringConstant.todoString}).then((value) {
        tabUpdate(i: 0);
        navigation(i: 0);
      });
    } else {
      List editStatus = await sharedPref.getEditTaskOffline ?? [];
      editStatus.add({
        "docId": task[index].id ?? "",
        "status": StringConstant.todoString,
      });
      sharedPref.setStatusOffline(editStatus);
      List<TaskModel> allTask = [];
      allTask = await sharedPref.getAllTask as List<TaskModel>;
      int indexData =
      allTask.indexWhere((element) => element.id == task[index].id);
      allTask[indexData] = TaskModel(
          id: allTask[indexData].id,
          status: StringConstant.todoString,
          title: allTask[indexData].title,
          dateTime: allTask[indexData].dateTime,
          description: allTask[indexData].description,
          endTime: allTask[indexData].endTime,
          isStart: allTask[indexData].isStart,
          startTime: allTask[indexData].startTime,
          timeHistory: allTask[indexData].timeHistory,
          totalOfDuration: allTask[indexData].totalOfDuration,
          userId: allTask[indexData].userId);
      await sharedPref.addAllTask(allTask);
      navigation(i: 0);
    }
    if (await ConnectivityWrapper.instance.isConnected) {
      await FirebaseConstant.updateCollection(
          docId: task[index].id ?? "",
          collectionName: StringConstant.taskCollection,
          value: {"status": StringConstant.todoString}).then((value) {
        tabUpdate(i: 0);
        navigation(i: 0);
      });
    } else {
      List editStatus = await sharedPref.getEditTaskOffline ?? [];
      editStatus.add({
        "docId": task[index].id ?? "",
        "status": StringConstant.todoString,
      });
      sharedPref.setStatusOffline(editStatus);
      List<TaskModel> allTask = [];
      allTask = await sharedPref.getAllTask as List<TaskModel>;
      int indexData =
      allTask.indexWhere((element) => element.id == task[index].id);
      allTask[indexData] = TaskModel(
          id: allTask[indexData].id,
          status: StringConstant.todoString,
          title: allTask[indexData].title,
          dateTime: allTask[indexData].dateTime,
          description: allTask[indexData].description,
          endTime: allTask[indexData].endTime,
          isStart: allTask[indexData].isStart,
          startTime: allTask[indexData].startTime,
          timeHistory: allTask[indexData].timeHistory,
          totalOfDuration: allTask[indexData].totalOfDuration,
          userId: allTask[indexData].userId);
      await sharedPref.addAllTask(allTask);
      navigation(i: 0);
    }
  }

  /// common Navigator for screen
  void editTaskNav(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewTaskScreen(
              userId: task[index].id,
              isEdit: true,
              title: task[index].title,
              description: task[index].description,
              index: widget.index),
        ));
  }

  Widget flotAction() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(isEdit: false),
            ));
      },
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2,
      child: const Icon(
        CupertinoIcons.add,
        color: TaskColors.backgroundColor,
      ),
    );
  }
}
