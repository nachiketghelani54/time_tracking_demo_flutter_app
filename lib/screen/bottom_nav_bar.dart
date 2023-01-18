import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/color_constant.dart';
import 'package:time_tracking_demo/screen/history/history_screen.dart';
import 'package:time_tracking_demo/screen/home/home_screen.dart';
import 'package:time_tracking_demo/screen/setting/setting_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  int selectedTab = 0;
  List<Widget> screenList = [
    HomeScreen(),
    HistoryScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Image.asset("assets/images/ic_home_unselect.png",scale: 2.9),label: "Home",activeIcon:  Image.asset("assets/images/ic_home_select.png",scale: 2.9,),),
        BottomNavigationBarItem(icon: Image.asset("assets/images/ic_history_unselect.png",scale: 2.9),label: "History",activeIcon: Image.asset("assets/images/ic_history_select.png",scale: 2.9,)),
        BottomNavigationBarItem(icon: Image.asset("assets/images/ic_setting_unselect.png",scale: 2.9),label: "Setting",activeIcon: Image.asset("assets/images/ic_setting_select.png",scale: 2.9,)),
      ],
      backgroundColor: TaskColors.primaryColor,
      elevation: 0,
      selectedItemColor: TaskColors.backgroundColor,

      currentIndex: selectedTab,
        onTap: (value) {
          setState(() {
            selectedTab = value;
          });
        },
      ),

      body: screenList[selectedTab],
    );
  }
}
