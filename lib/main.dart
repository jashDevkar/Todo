import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/home_screen.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoData>(
      create: (context) => TodoData(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}

// Heart of project (ALl logic is here)

class TodoData extends ChangeNotifier {
  List<TodoModel> todoLists = [];
  List<TodoModel> _safeList=[];



 bool allTasks=true;
 bool completedTask = false;
 bool highPriorityTask = false;

  Box _box = Hive.box('mybox');

  void addTask({String? title, required String priority, required String endDate}) {
    todoLists.add(TodoModel(
        title: title,
        dateEndTime: endDate,
        isChecked: false,
        priority: priority));

    List<Map<String, dynamic>> todoListsMap =
        todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    _safeList = [...todoLists];
    notifyListeners();
  }

  // this runs when no data is there in app
  void intializeDataBase() {
    todoLists = [
      TodoModel(
          title: 'My flutter todo',
          dateEndTime: DateTime.now().toString(),
          isChecked: false,
          priority: 'high'),
      TodoModel(
          title: 'Flutter app',
          dateEndTime: DateTime.now().toString(),
          isChecked: false,
          priority: 'low'),
    ];
    List<Map<String, dynamic>> todoListsMap =
        todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
  }

  //this will display all tasks at begining of the code
  void getAllTasks() {
    var myitems = _box.get('TODOS');
    todoLists=[];
    for (int i = 0; i < myitems.length; i++) {
      TodoModel todo = TodoModel.fromJson(myitems[i]);
      todoLists.add(todo);
    }
    _safeList=todoLists;
    notifyListeners();
  }

  //this will get all task for filters
  void getAllData(){
    todoLists = [..._safeList];
    notifyListeners();
  }

  //this will display only completed task
  void getCompletedTask(){
    List<TodoModel> completedList=[];
    todoLists=[..._safeList];
    for(int i=0;i<todoLists.length;i++){
      if(todoLists[i].isChecked == true){
        completedList.add(todoLists[i]);
      }
    }
    todoLists = [...completedList];
    notifyListeners();
  }

  // this will display high priority tasks
  void getHighPriorityTasks(){
    List<TodoModel> highPriorityList=[];
    todoLists = [..._safeList];
    for(int i=0;i<todoLists.length;i++){
      if(todoLists[i].priority == 'high'){
        highPriorityList.add(todoLists[i]);
      }
    }
    todoLists=[...highPriorityList];
    notifyListeners();
  }

  //get total count of tasks
  int getCount() {
    return todoLists.length;
  }

  //toggle checkList
  void checkTask(int position, value) {
    todoLists[position].isChecked = value;
    List<Map<String, dynamic>> todoListsMap =
        todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    notifyListeners();
  }

  //update data of task
  void updateTask({required String title,required String dateEndTime,required int position,required String priority}){
    TodoModel todo = todoLists[position];
    todo.title = title;
    todo.priority = priority;
    todo.dateEndTime=dateEndTime;
    notifyListeners();
  }

  //delete data while on long press
  void deleteTask(int position) {
    todoLists.removeAt(position);
    List<Map<String, dynamic>> todoListsMap =
        todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    notifyListeners();
  }
}
