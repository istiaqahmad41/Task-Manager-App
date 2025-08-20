import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_button/flutter_toggle_button.dart';
import 'package:hive/hive.dart';
import 'package:to_do_now/components/my_button.dart';
import 'package:to_do_now/components/new_button.dart';
import 'package:to_do_now/data/database.dart';

import '../components/dialogbox.dart';
import '../components/todo_tiles.dart';

class TodoHome extends StatefulWidget {
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final _myBox = Hive.box('mybox');

  final _controller = TextEditingController();

  ToDo_DataBase db = ToDo_DataBase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.CreateInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void SavePressed() {
    setState(() {
      db.todoTasks.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.UpdateDataBase();
  }

  void CheckBoxChanged(bool? value, int index) {
    setState(() {
      db.todoTasks[index][1] = !db.todoTasks[index][1];
    });
    db.UpdateDataBase();
  }

  void creatNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            OnSave: SavePressed,
            OnCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoTasks.removeAt(index);
    });
    db.UpdateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FF),
      body: Column(
        children: [
          FlutterToggleButton(
            items: [
              'My Tasks',
              'In-progress',
              'Completed',
            ],
            outerContainerColor: Colors.transparent,
            buttonWidth: 120,
            buttonHeight: 50,
            borderRadius: 25,
            buttonTextFontSize: 18,
            enableTextColor: Colors.white,
            disableTextColor: Colors.grey,
            enableTextFontWeight: FontWeight.bold,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: db.todoTasks.length,
                itemBuilder: (context, index) {
                  return TodoTiles(
                    taskName: db.todoTasks[index][0],
                    taskCompleted: db.todoTasks[index][1],
                    onChanged: (value) => CheckBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                }),
          )
        ],
      ),
    );
  }
}
