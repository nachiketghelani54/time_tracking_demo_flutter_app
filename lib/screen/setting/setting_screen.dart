import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);


  Widget buildListTile(String title,String imagePath,){
    return ListTile(leading: Image.asset(imagePath,color: Colors.black,scale: 2.9) ,
      title: Text(title,style: FontStyleText.text14W400LightBlack),
      trailing: Image.asset("assets/images/ic_forward.png",scale: 2.9,),
      contentPadding: EdgeInsets.symmetric(horizontal: 4),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text("Setting",style: TextStyle(color: TaskColors.backgroundColor,fontSize: 18,fontWeight: FontWeight.w500),),
        centerTitle: true,
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          buildListTile("History", "assets/images/ic_history_select.png"),
            Divider(color: TaskColors.hintColor,),
            buildListTile("Notification", "assets/images/ic_notification.png"),
            Divider(color: TaskColors.hintColor,),
            buildListTile("Theme", "assets/images/ic_theme.png"),
            Divider(color: TaskColors.hintColor,),
            buildListTile("Language", "assets/images/ic_laungauge.png"),

          ],
        ),
      ),
    );
  }
}
