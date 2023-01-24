import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/shared_preferences.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/models/task_model.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';

import '../../constants/color_constant.dart';
import '../bottom_nav/bottom_nav_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  String? userId;
  String? id;
  String? title;
  String? description;
  int? index;
  bool isEdit;

  AddNewTaskScreen(
      {Key? key,
      required this.isEdit,
      this.userId,
      this.id,
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
  List offlineEditTask = [];
  List offlineNewTask = [];
  List<TaskModel> allTask = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: "SAL | Create Api definition for ",
                      hintStyle: FontStyleText.text14W400Hint,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: Theme.of(context).textTheme.bodyText2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title must be required";
                    }
                  },
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
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Website UI design for...",
                    hintStyle: FontStyleText.text14W400Hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description must be required";
                    }
                  },
                  style: Theme.of(context).textTheme.bodyText2,
                  minLines: 4,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _submit(context);
                    }
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
                      style: TextStyle(
                          color: TaskColors.backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FirebaseConstant firebaseConstant = FirebaseConstant();

  _submit(BuildContext context) async {
    try {
      if (widget.isEdit) {
        print(await ConnectivityWrapper.instance.isConnected);
        if (await ConnectivityWrapper.instance.isConnected) {
          await FirebaseConstant.updateCollection(
              docId: widget.userId ?? '',
              collectionName: StringConstant.taskCollection,
              value: {
                'title': _titleController.text,
                'description': _descriptionController.text,
              });
        } else {
          offlineEditTask.clear();
          offlineEditTask = (await sharedPref.getEditTaskOffline) ?? [];
          offlineEditTask.add({
            "docId": "${widget.userId}",
            "collectionName": StringConstant.taskCollection,
            "title": _titleController.text,
            "description": _descriptionController.text,
          });
          sharedPref.setEditTaskOffline(offlineEditTask);
          allTask.addAll(await sharedPref.getAllTask as List<TaskModel>);
          int index = allTask.indexWhere((element) => element.id == widget.userId);
          allTask[index] = TaskModel(
              id: allTask[index].id,
              status: allTask[index].status,
              title: _titleController.text,
              dateTime: allTask[index].dateTime,
              description: _descriptionController.text,
              endTime: allTask[index].endTime,
              isStart: allTask[index].isStart,
              startTime: allTask[index].startTime,
              timeHistory: allTask[index].timeHistory,
              totalOfDuration: allTask[index].totalOfDuration,
              userId: allTask[index].userId);
          sharedPref.addAllTask(allTask).then((value) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomNavBarScreen(widget.index ?? 0)),
                (Route<dynamic> route) => false);
            context.read<TabBloc>().add(ChangeTabEvent(widget.index ?? 0));
          });
        }
      } else {
        if (await ConnectivityWrapper.instance.isConnected) {
          var id = UniqueKey().hashCode.toString();
          await FirebaseConstant.setCollection(
              collectionName: StringConstant.taskCollection,
              value: {
                "id": id.toString(),
                'userId': id.toString(),
                'title': _titleController.text,
                'description': _descriptionController.text,
                'dateTime': DateTime.now(),
                'timeHistory': [],
                'status': 'todo',
                'startTime': [],
                'endTime': [],
                'isPlay': false,
                'totalOfDuration': const Duration().toString()
              },
              id: id);
        } else {
          offlineNewTask.clear();
          offlineNewTask = (await sharedPref.getNewTaskOffline) ?? [];
          var id = UniqueKey().hashCode;
          offlineNewTask.add({
            "id": id.toString(),
            'userId': id.toString(),
            'title': _titleController.text,
            'description': _descriptionController.text,
            'dateTime': DateTime.now().toString(),
            'timeHistory': [],
            'status': 'todo',
            'startTime': [],
            'endTime': [],
            'isPlay': false,
            'totalOfDuration': const Duration().toString()
          });
          await sharedPref
              .setNewTaskOffline(offlineNewTask)
              .then((value) async {
            allTask.addAll(await sharedPref.getAllTask as List<TaskModel>);
            allTask.add(TaskModel(
                id: id.toString(),
                status: "todo",
                title: _titleController.text,
                dateTime: DateTime.now(),
                description: _descriptionController.text,
                endTime: [],
                startTime: [],
                timeHistory: [],
                totalOfDuration: const Duration(),
                userId: id.toString()));
          });

          await sharedPref.addAllTask(allTask);
        }
      }
      _titleController.clear();
      _descriptionController.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBarScreen(0)),
          (Route<dynamic> route) => false);
      context.read<TabBloc>().add(ChangeTabEvent(0));
    } catch (e) {
      print(e.toString());
    }
  }
}
