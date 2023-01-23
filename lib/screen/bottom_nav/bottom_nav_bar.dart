import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/history/history_screen.dart';
import 'package:time_tracking_demo/screen/home/home_screen.dart';
import 'package:time_tracking_demo/screen/setting/setting_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  var index;

  BottomNavBarScreen(this.index, {Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screenList = [];

  @override
  void initState() {
    screenList.add(HomeScreen(widget.index));
    screenList.add(const HistoryScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/ic_home_unselect.png",
                    scale: 2.9),
                label: context.localization.home,
                activeIcon: Image.asset(
                  "assets/images/ic_home_select.png",
                  scale: 2.9,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/ic_history_unselect.png",
                      scale: 2.9),
                  label: context.localization.history,
                  activeIcon: Image.asset(
                    "assets/images/ic_history_select.png",
                    scale: 2.9,
                  )),
              // BottomNavigationBarItem(icon: Image.asset("assets/images/ic_setting_unselect.png",scale: 2.9),label: context.localization.setting,activeIcon: Image.asset("assets/images/ic_setting_select.png",scale: 2.9,)),
            ],
            backgroundColor: TaskColors.primaryColor,
            elevation: 0,
            selectedItemColor: TaskColors.backgroundColor,
            unselectedItemColor: TaskColors.backgroundColor.withOpacity(0.5),
            currentIndex: state.selectedTab,
            onTap: (value) {
              context.read<BottomNavBloc>().add(ChangeTab(value));
            },
          );
        },
      ),
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return screenList[state.selectedTab];
        },
      ),
    );
  }
}
