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
import 'package:time_tracking_demo/screen/home/tabs/task_screen.dart';
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
    tabController.addListener(() {
      if (kDebugMode) {
        print(tabController.index);
      }
      context.read<TabBloc>().add(ClearDataEvent(tabController.index));
      context.read<TabBloc>().add(ChangeTabEvent(tabController.index));
    });
    tabController.animateTo(widget.index);
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
                            offset: Offset(110, 0),
                            color: Theme.of(context).appBarTheme.backgroundColor,
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
                                    style: Theme.of(context).textTheme.subtitle2),
                                onTap: () => context
                                    .read<ThemeBloc>()
                                    .add(ThemeChanged(
                                              theme: TaskTheme.lightTheme,
                                              status: true)),
                              ),
                              PopupMenuItem(
                                child: Text(context.localization.dark,
                                    style: Theme.of(context).textTheme.subtitle2),
                                onTap: () => context
                                    .read<ThemeBloc>()
                                    .add(ThemeChanged(
                                    theme: TaskTheme.darkTheme,
                                    status: true)),
                              ), PopupMenuItem(
                                child: Text(context.localization.red,
                                    style: Theme.of(context).textTheme.subtitle2),
                                onTap: () => context
                                    .read<ThemeBloc>()
                                    .add(ThemeChanged(
                                    theme: TaskTheme.redTheme,
                                    status: true)),
                              ), PopupMenuItem(
                                child: Text(context.localization.green,
                                    style: Theme.of(context).textTheme.subtitle2),
                                onTap: () => context
                                    .read<ThemeBloc>()
                                    .add(ThemeChanged(
                                    theme: TaskTheme.greenTheme,
                                    status: true)),
                              ),PopupMenuItem(
                                child: Text(context.localization.orange,
                                    style: Theme.of(context).textTheme.subtitle2),
                                onTap: () => context
                                    .read<ThemeBloc>()
                                    .add(ThemeChanged(
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
                        child: Text(context.localization.home,style: Theme.of(context).textTheme.headline2),
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
                        child: Text(context.localization.history,style: Theme.of(context).textTheme.headline2),
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
            labelStyle:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
            unselectedLabelStyle:  TextStyle(
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
