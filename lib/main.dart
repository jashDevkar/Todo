import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/home_screen.dart';



void main() async{

  //init hive
  await Hive.initFlutter();

  debugPrint = (String? message, {int? wrapWidth}) {};

  //open box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoData>(
      create: (context)=>TodoData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
      ),
    );
  }
}

class TodoData extends ChangeNotifier{
  List<TodoModel> todoLists=[];


  Box _box = Hive.box('mybox');

  void addTask({String? title,String? priority,String? endDate}){

    todoLists.add(TodoModel(title: title, dateEndTime: endDate, isChecked: false,priority: priority));

    List<Map<String, dynamic>> todoListsMap = todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    notifyListeners();
  }
  
  void intializeDataBase(){
    todoLists=[
      TodoModel(title: 'My flutter todo', dateEndTime: DateTime.now().toString(), isChecked: false,priority:'high'),
      TodoModel(title: 'Flutter app', dateEndTime: DateTime.now().toString(), isChecked: false,priority:'low'),
    ];
    List<Map<String, dynamic>> todoListsMap = todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
  }

  List<TodoModel> getTasks(){

   var myitems=_box.get('TODOS');
   print(myitems.length);
   for(int i=0;i<myitems.length;i++){
     TodoModel todo = TodoModel.fromJson(myitems[i]);
     todoLists.add(todo);
   }

    return todoLists;
  }

  int getCount(){
    return todoLists.length;
  }

  void checkTask(int position,value){
    todoLists[position].isChecked = value;
    List<Map<String, dynamic>> todoListsMap = todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    notifyListeners();
  }

  void deleteTask(int position){
    todoLists.removeAt(position);
    List<Map<String, dynamic>> todoListsMap = todoLists.map((todo) => todo.toJson()).toList();
    _box.put('TODOS', todoListsMap);
    notifyListeners();
  }


}


