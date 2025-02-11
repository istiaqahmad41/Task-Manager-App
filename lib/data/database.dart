import 'package:hive/hive.dart';

class ToDo_DataBase{

  List todoTasks = [];




  //reference box
  final _myBox = Hive.box('mybox');

  //run this  first time ever  opening the app
void CreateInitialData(){

  todoTasks=[
    ['Do Work',true],
    ['Do Exercise',false],

  ];

}

void loadData(){

  todoTasks= _myBox.get("TODOLIST");

}

void UpdateDataBase(){

  _myBox.put("TODOLIST", todoTasks);
}

}
