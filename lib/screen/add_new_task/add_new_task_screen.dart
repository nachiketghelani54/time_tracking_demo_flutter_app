import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';

import '../../constants/color_constant.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(context.localization.create_new_task,style: TextStyle(color: TaskColors.backgroundColor,fontSize: 18,fontWeight: FontWeight.w500),),
        centerTitle: true,
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(context.localization.title_name,style: FontStyleText.text14W400Hint,),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "SAL | Create Api definition for ",
                  hintStyle: FontStyleText.text14W400Hint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(context.localization.description,style: FontStyleText.text14W400Hint,),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Website UI design for...",
                  hintStyle: FontStyleText.text14W400Hint,

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

              ),
              minLines: 4,
              maxLines: null,
            ),
            SizedBox(height: 50,),

            Container(
              alignment: Alignment.center,
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(context.localization.create_task,style: FontStyleText.text16W500White,),
            )
          ],
        ),
      ),
    );
  }
}
