import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/shared_preferences.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';
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
    super.initState();
    _titleController = TextEditingController(text: widget.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  ///AppBar
  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: TaskColors.backgroundColor,
      title: Text(
        widget.isEdit
            ? context.localization.edit_task
            : context.localization.create_new_task,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  ///Body
  _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SizeConstant.size12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              _titleText(text: context.localization.title_name),
              _title(),
              SizeConstant.height20,

              ///Description
              _titleText(text: context.localization.description),
              _description(),
              SizeConstant.height50,

              ///Submit
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  ///Title
  _title() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
          hintText: context.localization.titleHint,
          hintStyle: FontStyleText.text14W400Hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      style: Theme.of(context).textTheme.bodyText2,
      validator: (value) {
        if (value!.isEmpty) {
          return context.localization.titleValidation;
        }
      },
    );
  }

  ///Description
  _description() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        hintText: context.localization.descriptionHint,
        hintStyle: FontStyleText.text14W400Hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return context.localization.descriptionValidation;
        }
      },
      style: Theme.of(context).textTheme.bodyText2,
      minLines: 4,
      maxLines: null,
    );
  }

  ///title name
  _titleText({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeConstant.size10),
      child: Text(
        text,
        style: FontStyleText.text14W400Hint,
      ),
    );
  }

  ///Submit Button
  _submitButton() {
    return GestureDetector(
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
            widget.isEdit
                ? context.localization.save_task
                : context.localization.create_task,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
  }

  ///Submit Task
  _submit(BuildContext context) async {
    if (widget.isEdit) {
      await _editTask();
    } else {
      await _createTask();
    }
    _titleController.clear();
    _descriptionController.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavBarScreen(0)),
        (Route<dynamic> route) => false);
    context.read<TabBloc>().add(const ChangeTabEvent(0));
  }

  ///Edit Task
  _editTask() async {
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
  }

  ///Create Task
  _createTask() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      var id = UniqueKey().hashCode.toString();
      await FirebaseConstant.setCollection(
          collectionName: StringConstant.taskCollection,
          value: {
            'id': id.toString(),
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
      await sharedPref.setNewTaskOffline(offlineNewTask).then((value) async {
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
}
