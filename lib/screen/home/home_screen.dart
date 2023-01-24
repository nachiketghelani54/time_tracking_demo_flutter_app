import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/constants/offline_preference.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';
import 'package:time_tracking_demo/screen/home/tabs/task_screen.dart';

import '../../constants/firebase_constant.dart';
import '../../constants/string_constant.dart';
import '../../constants/text_style.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme.dart';
import '../language_selection_screen.dart';

late TabController tabController;

class HomeScreen extends StatefulWidget {
  var index;

  HomeScreen(this.index, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (kDebugMode) {
        print(tabController.index);
      }
      context.read<TabBloc>().add(ClearDataEvent(tabController.index));
      context.read<TabBloc>().add(ChangeTabEvent(tabController.index));
    });
    tabController.animateTo(widget.index);
    setDataToStorage();
    ConnectivityWrapper.instance.onStatusChange.listen((event) async {
      if (event == ConnectivityStatus.CONNECTED) {
        setDataToStorage();

        List data = await sharedPref.getNewTaskOffline ?? [];
        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            await FirebaseConstant.setCollection(
                collectionName: StringConstant.taskCollection,
                value: {
                  "id": data[i]["id"].toString(),
                  'userId': data[i]["userId"],
                  'title': data[i]["title"],
                  'description': data[i]["description"],
                  'dateTime': DateTime.parse(data[i]["dateTime"]),
                  'timeHistory': data[i]["timeHistory"],
                  'status': data[i]["status"],
                  'startTime': data[i]["startTime"],
                  'endTime': data[i]["endTime"],
                  'isPlay': data[i]["isPlay"],
                  'totalOfDuration': data[i]["totalOfDuration"]
                },
                id: data[i]["id"].toString());
            data.removeAt(i);
          }
          await sharedPref.setNewTaskOffline(data);
        }

        List? dataForEdit = [];
        dataForEdit = await sharedPref.getEditTaskOffline;
        if (dataForEdit != null) {
          for (var i = 0; i < dataForEdit.length; i++) {
            if (dataForEdit[i]["docId"] != "") {
              await FirebaseConstant.updateCollection(
                  docId: dataForEdit[i]["docId"] ?? '',
                  collectionName: StringConstant.taskCollection,
                  value: {
                    'title': dataForEdit[i]["title"],
                    'description': dataForEdit[i]["description"],
                  });
            }
          }
          await sharedPref.setEditTaskOffline([]);
        }
        List dataForEditStatus = [];
        dataForEditStatus = await sharedPref.getStatusOffline ?? [];
        if (dataForEditStatus.isNotEmpty) {
          for (var i = 0; i < dataForEditStatus.length; i++) {
            await FirebaseConstant.updateCollection(
                docId: dataForEditStatus[i]["docId"] ?? '',
                collectionName: StringConstant.taskCollection,
                value: {
                  'status': dataForEditStatus[i]["status"],
                });
          }
          await sharedPref.setStatusOffline([]);
        }
        List dataStart = [];
        dataStart = await sharedPref
            .getStartOffline ?? [];
        if (dataStart.isNotEmpty) {
          for (var i = 0; i < dataStart.length; i++) {
            await FirebaseConstant.updateCollection(
                docId: dataStart[i]["docId"] ?? '',
                collectionName: StringConstant.taskCollection,
                value: {
                  'startTime': dataStart[i]["startTime"],
                  'isStart': dataStart[i]["isStart"],
                  "status" : dataStart[i]["status"]
                });
          }
          await sharedPref.setStartOffline([]);
          List dataEnd = [];
          dataEnd = await sharedPref.getEndOffline ?? [];
          if (dataEnd.isNotEmpty) {
            for (var i = 0; i < dataEnd.length; i++) {
              await FirebaseConstant.updateCollection(
                  docId: dataEnd[i]["docId"] ?? '',
                  collectionName: StringConstant.taskCollection,
                  value: {
                    'timeHistory': dataEnd[i]["timeHistory"],
                    'endTime': dataEnd[i]["endTime"],
                    'isStart': dataEnd[i]["isStart"],
                    'totalOfDuration': dataEnd[i]["totalOfDuration"]
                  });
            }
            await sharedPref.setEndOffline([]);
          }
          setDataToStorage();
        }
      }
    });
  }

  setDataToStorage() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      FirebaseConstant firebaseConstant = FirebaseConstant();
      await sharedPref.addAllTask(await firebaseConstant.allTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (context, bottomState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const FlutterLogo(
                                  size: 80,
                                ),
                                Text(
                                  "Flutter",
                                  style: FontStyleText.text22W500White,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          PopupMenuButton(
                            offset: const Offset(110, 0),
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  context.localization.theme,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(context.localization.light,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                onTap: () => context.read<ThemeBloc>().add(
                                    ThemeChanged(
                                        theme: TaskTheme.lightTheme,
                                        status: true)),
                              ),
                              PopupMenuItem(
                                child: Text(context.localization.dark,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                onTap: () => context.read<ThemeBloc>().add(
                                    ThemeChanged(
                                        theme: TaskTheme.darkTheme,
                                        status: true)),
                              ),
                              PopupMenuItem(
                                child: Text(context.localization.red,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                onTap: () => context.read<ThemeBloc>().add(
                                    ThemeChanged(
                                        theme: TaskTheme.redTheme,
                                        status: true)),
                              ),
                              PopupMenuItem(
                                child: Text(context.localization.green,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                onTap: () => context.read<ThemeBloc>().add(
                                    ThemeChanged(
                                        theme: TaskTheme.greenTheme,
                                        status: true)),
                              ),
                              PopupMenuItem(
                                child: Text(context.localization.orange,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                onTap: () => context.read<ThemeBloc>().add(
                                    ThemeChanged(
                                        theme: TaskTheme.orangeTheme,
                                        status: true)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).hintColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Row(
                        children: const [LanguageSelection()],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).hintColor,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<BottomNavBloc>().add(const ChangeTab(0));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.localization.home,
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).hintColor,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<BottomNavBloc>().add(const ChangeTab(1));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.localization.history,
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).hintColor,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        // foregroundColor: Theme.of(context).backgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        // leading: InkWell(
        //   onTap: (){},
        //   child: Image.asset("assets/images/ic_menu.png",scale: 2.9),
        // ),
      ),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Text(
                context.localization.to_do,
              ),
              Text(context.localization.in_progress),
              Text(context.localization.done),
            ],
            controller: tabController,
            unselectedLabelColor: Theme.of(context).hintColor,
            labelColor: Theme.of(context).indicatorColor,
            labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
            unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor),
            // padding: EdgeInsets.zero,
            // indicatorPadding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.all(10),
            indicatorColor: Theme.of(context).indicatorColor,
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              TaskScreen(index: 0),
              TaskScreen(index: 1),
              TaskScreen(index: 2)
            ]),
          )
        ],
      ),
    );
  }
}
