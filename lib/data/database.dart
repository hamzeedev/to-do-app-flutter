import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

List toDoList = [];

  //reference of box
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList = [

      ['Make Tutorial', false],
      ['Do Exercise', false],

    ];
  }

  //load data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");

  }

  //update database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);

  }
}