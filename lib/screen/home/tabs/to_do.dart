import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/main.dart';
import 'package:time_tracking_demo/screen/add_new_task/add_new_task_screen.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> with WidgetsBindingObserver {
  Timer? timer;

  DateTime? dateTime;

  Future saveCurrentDateTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("date_time", DateTime.now().toString());
  }

  getPastDateTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("date_time");
    if (data != null) {
      dateTime = DateTime.parse(data.toString());
    }
  }

  startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (time) async {
      await saveCurrentDateTime();
      if (dateTime != null) {
        print(dateTime!.second + 1);
      } else {
        print(time.tick);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      saveCurrentDateTime().then((value) {
        print("app terminated");
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getPastDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: const Text(
                                "SAL | Create Api definition for ",
                                style: TextStyle(
                                    color: TaskColors.lightBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Website UI Design for",
                                style: TextStyle(
                                    color: TaskColors.hintColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Container(
                                decoration: const BoxDecoration(),
                                child: PopupMenuButton(
                                  constraints:
                                      const BoxConstraints(maxWidth: 130),
                                  offset: const Offset(110, 0),
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  child: const Icon(Icons.more_vert),
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
                                                        isEdit: true),
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/edit.png"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              context.localization.edit,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/add.png",
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(context.localization.create,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/move.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            context.localization.move,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {},
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "21/10/2023",
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "21/10/2023",
                                          style: FontStyleText
                                              .text12W400LightBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  InkWell(
                                    onTap: () {
                                      startTimer();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: TaskColors.primaryColor,
                                      ),
                                      child: Text(
                                        context.localization.stop,
                                        style: FontStyleText.text14W500White,
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
              )),
          Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Row(
                children: [
                  Container(
                    height: 140,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ListTile(
                              title: Text(
                                "SAL | Create Api definition for ",
                                style: TextStyle(
                                    color: TaskColors.lightBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Website UI Design for",
                                style: TextStyle(
                                    color: TaskColors.hintColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(Icons.more_vert_outlined),
                            ),
                            Divider(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "21/10/2023",
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "21/10/2023",
                                          style: FontStyleText
                                              .text12W400LightBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 35,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: TaskColors.primaryColor,
                                    ),
                                    child: Text(
                                      "Stop",
                                      style: FontStyleText.text14W500White,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTaskScreen(),
              ));
        },
        child: Icon(CupertinoIcons.add),
        backgroundColor: TaskColors.primaryColor,
        elevation: 0,
      ),
    );
  }
}
