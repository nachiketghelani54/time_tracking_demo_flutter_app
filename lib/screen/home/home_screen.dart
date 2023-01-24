import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';
import 'package:time_tracking_demo/screen/home/widgets/task_screen.dart';
import 'package:time_tracking_demo/screen/home/widgets/drawer_widget.dart';

late TabController tabController;

class HomeScreen extends StatefulWidget {
  int indexValue = 0;

  HomeScreen(this.indexValue, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      context.read<TabBloc>().add(ClearDataEvent(tabController.index));
      context.read<TabBloc>().add(ChangeTabEvent(tabController.index));
    });
    tabController.animateTo(widget.indexValue);
    FirebaseConstant.fetchHomeTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: _appBar(),
      body: _body(),
    );
  }

  ///Appbar Widget
  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  ///Body Widget
  _body() {
    return Column(
      children: [
        _tabBar(),
        _tabBarView(),
      ],
    );
  }

  ///tabBar
  _tabBar() {
    return TabBar(
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
      unselectedLabelStyle: Theme.of(context).textTheme.headline5,
      labelStyle: Theme.of(context).textTheme.headline4,
      labelPadding: const EdgeInsets.all(SizeConstant.size10),
      indicatorColor: Theme.of(context).indicatorColor,
    );
  }

  ///tabBarView
  _tabBarView() {
    return Expanded(
      child: TabBarView(controller: tabController, children: [
        TaskScreen(index: SizeConstant.index0),
        TaskScreen(index: SizeConstant.index1),
        TaskScreen(index: SizeConstant.index2)
      ]),
    );
  }
}
