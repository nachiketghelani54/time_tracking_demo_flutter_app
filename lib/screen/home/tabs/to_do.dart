import 'dart:async';
import 'dart:convert';

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
import '../../../constants/string_constant.dart';
import '../../bottom_nav/bottom_nav_bar.dart';
import '../home_screen.dart';

class ToDoScreen extends StatefulWidget {
  int index;
  ToDoScreen({required this.index});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          if (state is TabLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return state.taskList?.isEmpty ?? true
              ? const Center(
                  child: Text('No TODO Task found'),
                )
              : ListView.builder(
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
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: TaskColors.backgroundColor,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(3),
                                          topLeft: Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(4, 4),
                                            blurRadius: 10)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          state.taskList?[index].title ?? "",
                                          style: const TextStyle(
                                              color: TaskColors.lightBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          state.taskList?[index].description ??
                                              "",
                                          style: const TextStyle(
                                              color: TaskColors.hintColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: Container(
                                          decoration: const BoxDecoration(),
                                          child: PopupMenuButton(
                                            constraints: const BoxConstraints(
                                                maxWidth: 130),
                                            offset: const Offset(110, 0),
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor,
                                            child: const Icon(Icons.more_vert),
                                            itemBuilder: (ctx) => [
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
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
                                                                  index: 0),
                                                        ));
                                                  },
                                                  child: SizedBox(
                                                    width: 130,
                                                    height: 40,
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                              "assets/images/edit.png"),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            context.localization
                                                                .edit,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
                                                  child: SizedBox(
                                                    width: 130,
                                                    height: 40,
                                                    child: Center(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/add.png",
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              context
                                                                  .localization
                                                                  .create,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
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
                                                    child: SizedBox(
                                                      width: 130,
                                                      height: 40,
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/move.png"),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              context
                                                                  .localization
                                                                  .move,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (ctx) => [
                                                      PopupMenuItem(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await FirebaseConstant
                                                                .updateCollection(
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
                                                                  context.read<TabBloc>().add(
                                                                      ChangeTabEvent(index ?? 0));
                                                              Navigator.of(context).pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BottomNavBarScreen(
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
                                                                  fontSize: 14,
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
                                                            await FirebaseConstant
                                                                .updateCollection(
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
                                                                  context.read<TabBloc>().add(
                                                                      ChangeTabEvent(index ?? 0));
                                                              Navigator.of(context).pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BottomNavBarScreen(
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
                                                                        FontWeight
                                                                            .w500,
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                          color: TaskColors.hintColor,
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
                                                    style: FontStyleText
                                                        .text12W400LightBlack,
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
                                                    style: FontStyleText
                                                        .text12W400LightBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Expanded(child: SizedBox()),
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

                                                if (state.taskList![index]
                                                        .isStart ??
                                                    false) {
                                                  endTime.add(DateTime.now()
                                                      .toString());
                                                  totalHistory.add(DateTime
                                                          .parse(endTime.last)
                                                      .difference(
                                                          DateTime.parse(
                                                              startTime.last))
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
                                                        'timeHistory':
                                                            totalHistory,
                                                        'endTime': endTime,
                                                        'isStart': false
                                                      });
                                                } else {
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
                                                      TaskColors.primaryColor,
                                                ),
                                                child: Text(
                                                  state.taskList![index]
                                                              .isStart ??
                                                          false
                                                      ? context
                                                          .localization.stop
                                                      : context
                                                          .localization.start,
                                                  style: FontStyleText
                                                      .text14W500White,
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
        child: Icon(CupertinoIcons.add),
        backgroundColor: TaskColors.primaryColor,
        elevation: 0,
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
