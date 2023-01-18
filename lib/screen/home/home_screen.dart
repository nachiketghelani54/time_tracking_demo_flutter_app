import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/screen/home/tabs/done.dart';
import 'package:time_tracking_demo/screen/home/tabs/in_progress.dart';
import 'package:time_tracking_demo/screen/home/tabs/to_do.dart';

class HomeScreen extends StatefulWidget {



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
 late TabController tabController;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: TaskColors.primaryColor,
  foregroundColor: TaskColors.backgroundColor,
  elevation: 0,
  leading: InkWell(
    onTap: (){},
    child: Image.asset("assets/images/ic_menu.png",scale: 2.9),
  ),
  actions: [
    IconButton(onPressed: (){}, icon: Image.asset("assets/images/ic_notification.png",scale: 2.9,))
  ],
),
      body: Column(
        children: [
          TabBar(tabs: [
            Text("To do",),
            Text("In Progress"),
            Text("Done"),
          ],controller: tabController,
          labelColor: TaskColors.primaryColor,
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: TaskColors.primaryColor),
            unselectedLabelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: TaskColors.hintColor),
            // padding: EdgeInsets.zero,
            // indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.all(10),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ToDoScreen(),
                InProgressScreen(),
                DoneScreen()
              ],),
          )
        ],
      ),
    );
  }
}
