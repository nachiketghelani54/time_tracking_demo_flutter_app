import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/models/task_model.dart';
import 'package:time_tracking_demo/screen/add_new_task/add_new_task_screen.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';

import '../../../constants/firebase_constant.dart';
import '../../../constants/function.dart';
import '../../../constants/notification_helper.dart';
import '../../../constants/string_constant.dart';
import '../../../theme/widget_theme/colors_and_text_style.dart';
import '../../bottom_nav/bottom_nav_bar.dart';

class TaskScreen extends StatefulWidget {
  int index;

  TaskScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          if (state is TabLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return state.taskList?.isEmpty ?? true
              ? Center(
                  child: Text(getTaskString(widget.index)),
                )
              : Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                    itemCount: state.taskList?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                height: 140,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: getColor(
                                      state.taskList?[index].status ?? ''),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration:  BoxDecoration(
                                        color:  Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(3),
                                            topLeft: Radius.circular(3)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).shadowColor,
                                              offset: Offset(0, 4),
                                              blurRadius: 10)
                                        ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            state.taskList?[index].title ?? "",
                                            style: Theme.of(context).textTheme.headline2,
                                          ),
                                          subtitle: Text(
                                            state.taskList?[index].description ??
                                                "",
                                            style:  Theme.of(context).textTheme.headline5,
                                          ),
                                          trailing: Container(
                                            decoration: const BoxDecoration(),
                                            child: PopupMenuButton(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 130),
                                              offset: const Offset(110, 0),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              child:  Icon(Icons.more_vert,color: Theme.of(context).iconTheme.color,),
                                              itemBuilder: (ctx) => [
                                                PopupMenuItem(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddNewTaskScreen(
                                                                    userId: state
                                                                        .taskList?[
                                                                            index]
                                                                        .id,
                                                                    isEdit: true,
                                                                    title: state
                                                                        .taskList?[
                                                                            index]
                                                                        .title,
                                                                    description: state
                                                                        .taskList?[
                                                                            index]
                                                                        .description,
                                                                    index: widget
                                                                        .index),
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/edit.png",color: Theme.of(context).textTheme.headline1?.color,),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          context
                                                              .localization.edit,
                                                          style: Theme.of(context).textTheme.headline1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddNewTaskScreen(
                                                                    isEdit:
                                                                        false),
                                                          ));
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/add.png",color:Theme.of(context).textTheme.headline1?.color
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            context.localization
                                                                .create,
                                                            style:
                                                            Theme.of(context).textTheme.headline1),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                ),
                                                PopupMenuItem(
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: PopupMenuButton(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 130),
                                                      offset:
                                                          const Offset(110, 0),
                                                      color: Theme.of(context)
                                                          .appBarTheme
                                                          .backgroundColor,
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                              "assets/images/move.png",color: Theme.of(context).textTheme.headline1?.color,),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            context.localization
                                                                .move,
                                                            style:
                                                                Theme.of(context).textTheme.headline1,
                                                          ),
                                                        ],
                                                      ),
                                                      itemBuilder: (ctx) {
                                                        if (widget.index == 0) {
                                                          return [
                                                        PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .inProgressString
                                                                      }).then(
                                                                      (value) {
                                                                        Navigator.of(context).pushAndRemoveUntil(
                                                                            MaterialPageRoute(
                                                                                builder: (context) => BottomNavBarScreen(
                                                                                    1)),
                                                                                (Route<dynamic>
                                                                            route) =>
                                                                            false);
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            1));

                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                          child: Text(
                                                            context.localization
                                                                .in_progress,
                                                            style:
                                                                const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .doneString
                                                                      }).then(
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            2));
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) => BottomNavBarScreen(
                                                                                2)),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                        context
                                                                            .localization
                                                                            .done,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                                        )),
                                                            ),
                                                          ),
                                                        ),
                                                            ),
                                                          ];
                                                        } else if (widget.index ==
                                                            1) {
                                                          return [
                                                        PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .todoString
                                                                      }).then(
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            0));
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) => BottomNavBarScreen(
                                                                                0)),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                          child: Text(
                                                                      context
                                                                          .localization
                                                                          .to_do,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .doneString
                                                                      }).then(
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            2));
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) => BottomNavBarScreen(
                                                                                2)),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                        context
                                                                            .localization
                                                                  .done,
                                                              style:
                                                                  const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ];
                                                        } else {
                                                          return [
                                                            PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .todoString
                                                                      }).then(
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            0));
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) => BottomNavBarScreen(
                                                                                0)),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                      context
                                                                          .localization
                                                                          .to_do,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  await FirebaseConstant.updateCollection(
                                                                      docId: state
                                                                              .taskList?[index]
                                                                              .id ??
                                                                          "",
                                                                      collectionName: StringConstant.taskCollection,
                                                                      value: {
                                                                        "status":
                                                                            StringConstant
                                                                                .inProgressString
                                                                      }).then(
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TabBloc>()
                                                                        .add(ChangeTabEvent(
                                                                            1));
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) => BottomNavBarScreen(
                                                                                1)),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                  width: 130,
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                        context
                                                                            .localization
                                                                            .in_progress,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                              )),
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
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      state.taskList?[index]
                                                              .dateTime
                                                              .toString()
                                                              .split(" ")
                                                              .last
                                                              .split(".")
                                                              .first ??
                                                          "",
                                                      style: Theme.of(context).textTheme.headline6,
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
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      state.taskList?[index]
                                                              .dateTime
                                                              .toString()
                                                              .split(" ")
                                                              .first ??
                                                          "",
                                                      style: Theme.of(context).textTheme.headline6,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: SizedBox()),
                                              InkWell(
                                                onTap: () async {
                                                  List<String> startTime = state
                                                      .taskList![index]
                                                      .startTime!;
                                                  List<String> endTime = state
                                                      .taskList![index].endTime!;
                                                  List<String> totalHistory =
                                                      state.taskList![index]
                                                          .timeHistory!;
                                                  Duration? total;

                                                  if (state.taskList![index]
                                                          .isStart ??
                                                      false) {
                                                    NotificationService()
                                                        .showNotification(
                                                            UniqueKey().hashCode,
                                                            state.taskList![index]
                                                                .title
                                                                .toString(),
                                                            "congratulations! You done the task.");
                                                    endTime.add(DateTime.now()
                                                        .toString());
                                                    totalHistory.add(DateTime
                                                            .parse(endTime.last)
                                                        .difference(
                                                            DateTime.parse(
                                                                startTime.last))
                                                        .toString());
                                                    for (int i = 0;
                                                        i <
                                                            state
                                                                .taskList![index]
                                                                .timeHistory!
                                                                .length;
                                                        i++) {
                                                      Duration dt = parseDuration(
                                                          state.taskList![index]
                                                              .timeHistory![i]);
                                                      total = total == null
                                                          ? parseDuration(state
                                                              .taskList![index]
                                                              .timeHistory![i])
                                                          : total = Duration(
                                                              days: total.inDays +
                                                                  dt.inDays,
                                                              microseconds: total
                                                                      .inMicroseconds +
                                                                  dt
                                                                      .inMicroseconds,
                                                              milliseconds: total
                                                                      .inMilliseconds +
                                                                  dt
                                                                      .inMilliseconds,
                                                              minutes: total.inMinutes +
                                                                  dt.inMinutes,
                                                              hours: total.inHours +
                                                                  dt.inHours,
                                                              seconds: total
                                                                      .inSeconds +
                                                                  dt.inSeconds);
                                                    }
                                                    await FirebaseConstant
                                                        .updateCollection(
                                                            docId: state
                                                                    .taskList?[
                                                                        index]
                                                                    .id ??
                                                                '',
                                                            collectionName:
                                                                StringConstant
                                                                    .taskCollection,
                                                            value: {
                                                          'timeHistory':
                                                              totalHistory,
                                                          'endTime': endTime,
                                                          'isStart': false,
                                                          'totalOfDuration':
                                                              total.toString()
                                                        });
                                                  } else {
                                                    NotificationService()
                                                        .showNotification(
                                                            UniqueKey().hashCode,
                                                            state.taskList![index]
                                                                .title
                                                                .toString(),
                                                            "You started the task.");
                                                    startTime.add(DateTime.now()
                                                        .toString());
                                                    await FirebaseConstant
                                                        .updateCollection(
                                                            docId: state
                                                                    .taskList?[
                                                                        index]
                                                                    .id ??
                                                                '',
                                                            collectionName:
                                                                StringConstant
                                                                    .taskCollection,
                                                            value: {
                                                          'startTime': startTime,
                                                          'isStart': true
                                                        });
                                                  }
                                                  context.read<TabBloc>().add(
                                                      ChangeTabEvent(index ?? 0));
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 80,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color:
                                                    Theme.of(context).primaryColor,
                                                  ),
                                                  child: Text(
                                                    state.taskList![index]
                                                                .isStart ??
                                                            false
                                                        ? context
                                                            .localization.stop
                                                        : context
                                                            .localization.start,
                                                    style: TextStyle(
                                                        color:  Color(0xffFFFFFF),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ));
                    },
                  ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTaskScreen(isEdit: false),
              ));
        },
        child: Icon(CupertinoIcons.add,color: TaskColors.backgroundColor,),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
    );
  }
}

class PrefTimeModel {
  bool isPlay;

  // String currentVal;
  String startDateTime;
  String? endDateTime;

  PrefTimeModel(
      {required this.isPlay, required this.startDateTime, this.endDateTime});

  factory PrefTimeModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefTimeModel(
        isPlay: parsedJson['isPlay'] ?? "",
        // currentVal: parsedJson['currentVal'] ?? "",
        startDateTime: parsedJson['currentDateTime'] ?? "",
        endDateTime: parsedJson['endDateTime'] ?? "");
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["isPlay"] = isPlay;
    // map["currentVal"] = currentVal;
    map["currentDateTime"] = startDateTime;
    map["endDateTime"] = endDateTime;
    // Add all other fields
    return map;
  }
}
