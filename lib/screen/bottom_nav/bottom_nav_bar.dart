import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/assets_constant.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/history/history_screen.dart';
import 'package:time_tracking_demo/screen/home/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  int indexValue;

  BottomNavBarScreen(this.indexValue, {Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screenList = [];

  @override
  void initState() {
    screenList.add(HomeScreen(widget.indexValue));
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
                icon: Image.asset(Assets.lib.images.homeUnSelectIcon.path,
                    scale: 2.9),
                label: context.localization.home,
                activeIcon: Image.asset(
                  Assets.lib.images.homeSelectIcon.path,
                  scale: 2.9,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(Assets.lib.images.historyUnSelectIcon.path,
                      scale: 2.9),
                  label: context.localization.history,
                  activeIcon: Image.asset(
                    Assets.lib.images.historySelectIcon.path,
                    scale: 2.9,
                  )),
            ],
            backgroundColor: Theme.of(context).primaryColor,
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
