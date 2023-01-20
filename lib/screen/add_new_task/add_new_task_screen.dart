import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';

import '../../constants/color_constant.dart';

class AddNewTaskScreen extends StatefulWidget {
  String? userId;
  String? title;
  String? description;
  int? index;
  bool isEdit;

  AddNewTaskScreen(
      {Key? key,
      required this.isEdit,
      this.userId,
      this.title,
      this.description,
      this.index})
      : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          widget.isEdit == true
              ? context.localization.edit_task
              : context.localization.create_new_task,
          style: const TextStyle(
              color: TaskColors.backgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
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
              child: Text(
                context.localization.title_name,
                style: FontStyleText.text14W400Hint,
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: "SAL | Create Api definition for ",
                  hintStyle: FontStyleText.text14W400Hint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                context.localization.description,
                style: FontStyleText.text14W400Hint,
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Website UI design for...",
                hintStyle: FontStyleText.text14W400Hint,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              minLines: 4,
              maxLines: null,
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
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
                child: Text(
                  widget.isEdit == true
                      ? context.localization.save_task
                      : context.localization.create_task,
                  style: FontStyleText.text16W500White,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FirebaseConstant firebaseConstant = FirebaseConstant();

  _submit(BuildContext context) async {
    try {
      if (widget.isEdit) {
        await FirebaseConstant.updateCollection(
            docId: widget.userId ?? '',
            collectionName: StringConstant.taskCollection,
            value: {
              'title': _titleController.text,
              'description': _descriptionController.text,
            });
        FirebaseAnalytics.instance.logEvent(
          name: "EditTask",
          parameters: {
            'userId': await firebaseConstant.userId,
            'title': _titleController.text,
            'description': _descriptionController.text,
            'dateTime': DateTime.now(),
          },
        );
      } else {
        await FirebaseConstant.setCollection(
            collectionName: StringConstant.taskCollection,
            value: {
              'userId': await firebaseConstant.userId,
              'title': _titleController.text,
              'description': _descriptionController.text,
              'dateTime': DateTime.now(),
              'timeHistory': [],
              'status': 'todo',
              'startTime': [],
              'endTime': [],
              'isPlay': false
            });
        FirebaseAnalytics.instance.logEvent(
          name: "CreateTask",
          parameters: {
            'userId': await firebaseConstant.userId,
            'title': _titleController.text,
            'description': _descriptionController.text,
            'dateTime': DateTime.now(),
            'timeHistory': [],
            'status': 'todo',
          },
        );
      }
      _titleController.clear();
      _descriptionController.clear();
      context.read<TabBloc>().add(ChangeTabEvent(widget.index ?? 0));
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
