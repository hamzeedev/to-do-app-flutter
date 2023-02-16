import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskapp/data/database.dart';
import 'package:taskapp/util/dialog_box.dart';
import 'package:taskapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//reference of hive box
final _myBox = Hive.box('mybox');
ToDoDataBase db = ToDoDataBase();

@override
  void initState() {
    // if this is first time create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();

    } else{
      db.loadData();
    }
    super.initState();
  }


final _controller = TextEditingController();

 

//function call for check box
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();


  }

  //save button method
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
     db.updateDataBase();
  }

  //add button function call
    void createNewTask(){
      showDialog(
        context: context, 
        builder: (context){
        return DialogBox(
          conroller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),

        );
      },
      );
      
    }
    //delete task
    void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
       db.updateDataBase();

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("DAILY TASK REMINDER"),
        backgroundColor: Colors.indigo,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: createNewTask,
        child: Icon( Icons.add),
         ),

      body: ListView.builder(

        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index), 
            deleteFunction: (context) => deleteTask(index),
            );
        },
        
      ),
    );
  }
}