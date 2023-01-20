import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';
import 'package:time_tracking_demo/screen/home/tabs/done.dart';
import 'package:time_tracking_demo/screen/home/tabs/in_progress.dart';
import 'package:time_tracking_demo/screen/home/tabs/to_do.dart';

import '../../constants/text_style.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme.dart';
import '../../theme/widget_theme/colors_and_text_style.dart';
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
    tabController.animateTo(widget.index);
    tabController.addListener(() {
      if (kDebugMode) {
        print(tabController.index);
      }
      context.read<TabBloc>().add(ChangeTabEvent(tabController.index));
    });
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
                      color: TaskColors.primaryColor,
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
                          Text(
                            context.localization.theme,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: DayNightSwitcherIcon(
                                moonColor: mainBackGroundColor,
                                isDarkModeEnabled: state.status ?? false,
                                onStateChanged: (val) {
                                  context.read<ThemeBloc>().add(ThemeChanged(
                                      theme: val
                                          ? TaskTheme.darkTheme
                                          : TaskTheme.lightTheme,
                                      status: val));
                                },
                              )),
                        ],
                      ),
                    ),
                    const Divider(
                      color: TaskColors.dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Row(
                        children: const [LanguageSelection()],
                      ),
                    ),
                    const Divider(
                      color: TaskColors.dividerColor,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<BottomNavBloc>().add(const ChangeTab(0));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.localization.home),
                      ),
                    ),
                    const Divider(
                      color: TaskColors.dividerColor,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<BottomNavBloc>().add(const ChangeTab(1));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.localization.history),
                      ),
                    ),
                    const Divider(
                      color: TaskColors.dividerColor,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: TaskColors.backgroundColor,
        elevation: 0,
        // leading: InkWell(
        //   onTap: (){},
        //   child: Image.asset("assets/images/ic_menu.png",scale: 2.9),
        // ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/ic_notification.png",
                scale: 2.9,
              ))
        ],
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
            unselectedLabelColor: TaskColors.hintColor,
            labelColor: TaskColors.primaryColor,
            labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: TaskColors.primaryColor),
            unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: TaskColors.hintColor),
            // padding: EdgeInsets.zero,
            // indicatorPadding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.all(10),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ToDoScreen(),
                const InProgressScreen(),
                const DoneScreen()
              ],
            ),
          )
        ],
      ),
    );
  }
}
