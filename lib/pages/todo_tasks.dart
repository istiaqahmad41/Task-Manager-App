

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:to_do_now/components/my_button.dart';

import '../components/dialogbox.dart';
import '../data/database.dart'; // For date formatting

class TodoTasks extends StatefulWidget {
  const TodoTasks({super.key});

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  final _myBox = Hive.box('mybox');

  final _controller = TextEditingController();

  ToDo_DataBase db = ToDo_DataBase();
  DateTime _selectedDate = DateTime.now();

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // <– shrink to fit children
          children: [
            Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      ' ${DateFormat('MMM, yyyy').format(_selectedDate)}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    MyButton(text: 'Add Task', OnPressed:creatNewTask )
                  ],
                )
            ),
            const SizedBox(height: 10),


            SizedBox(
              height: 100,
              child: HorizontalWeekCalendar(
                showTopNavbar: false,
                minDate: DateTime(2020, 12, 31),
                maxDate: DateTime(2032, 1, 31),
                initialDate: _selectedDate,
                showNavigationButtons: false,
                inactiveBackgroundColor: const Color(0xFFF2F5FF),
                inactiveTextColor: Colors.black,
                borderRadius: BorderRadius.circular(10),
                monthColor: Colors.black,
                activeBackgroundColor: Colors.blueAccent,
                activeTextColor: Colors.white,
                scrollPhysics: const BouncingScrollPhysics(),
                weekStartFrom: WeekStartFrom.Sunday,

              ),
            ),
          ],
        )

      ),
    );
  }
}
