import 'package:flutter/material.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';

import '../../constants/color_constant.dart';

class AddNewTaskScreen extends StatelessWidget {
  AddNewTaskScreen({Key? key}) : super(key: key);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _discriptionController = TextEditingController();
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
              controller: _titleController,
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
              controller: _discriptionController,
              decoration: InputDecoration(
                  hintText: "Website UI design for...",
                  hintStyle: FontStyleText.text14W400Hint,

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

              ),
              minLines: 4,
              maxLines: null,
            ),
            SizedBox(height: 50,),

            GestureDetector(
              onTap: (){
                _submit(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(context.localization.create_task,style: FontStyleText.text16W500White,),
              ),
            )
          ],
        ),
      ),
    );
  }
  FirebaseConstant firebaseConstant = FirebaseConstant();
  _submit(BuildContext context) async {
    try{
      await FirebaseConstant.setCollection(
          collectionName: StringConstant.taskCollection, value: {
        'userId': await firebaseConstant.userId,
        'title': _titleController.text,
        'description': _discriptionController.text,
        'dateTime': DateTime.now(),
        'timeHistory': [],
        'status': 'todo',
      });
      _titleController.clear();
      _discriptionController.clear();
      Navigator.pop(context);
    }catch(e){
      print(e.toString());
    }

  }
}
