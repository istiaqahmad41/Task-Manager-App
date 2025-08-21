import 'package:hive/hive.dart';

class ToDo_DataBase {
  List todoTasks = [];

  final _myBox = Hive.box('mybox');

  void CreateInitialData() {
    todoTasks = [
      ['Do Work', true],
      ['Do Exercise', false],
      ['Grocery shopping', false],
      ['Backup files to cloud', true],

    ];
  }

  void loadData() {
    todoTasks = _myBox.get("TODOLIST");
  }

  void UpdateDataBase() {
    _myBox.put("TODOLIST", todoTasks);
  }
}
