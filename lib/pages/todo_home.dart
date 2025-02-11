import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_now/data/database.dart';

import '../components/dialogbox.dart';
import '../components/todo_tiles.dart';

class TodoHome extends StatefulWidget {
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {

  //reference the hive box
  final _myBox = Hive.box('mybox');

//text controller
  final _controller = TextEditingController();

  //instant of database
  ToDo_DataBase db = ToDo_DataBase();

  @override
  void initState() {
    // if this is the 1st time ever opening this app
    if(_myBox.get('TODOLIST')== null){

      db.CreateInitialData();
    }else{
      //data exists already
      db.loadData();
    }
    super.initState();
  }



  //on save button press save a new task
  void SavePressed() {
    setState(() {
      db.todoTasks.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.UpdateDataBase();
  }

  // on checkbox press
  void CheckBoxChanged(bool? value, int index) {
    setState(() {
      db.todoTasks[index][1] = !db.todoTasks[index][1];
    });
    db.UpdateDataBase();
  }

//create new task
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

  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoTasks.removeAt(index);
    });
    db.UpdateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.lime,
        title: Text(
          'To Do',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView.builder(
          itemCount: db.todoTasks.length,
          itemBuilder: (context, index) {
            return TodoTiles(
              taskName: db.todoTasks[index][0],
              taskCompleted: db.todoTasks[index][1],
              onChanged: (value) => CheckBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lime,
        foregroundColor: Colors.black,
        onPressed: creatNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
