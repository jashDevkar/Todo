import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/home_screen.dart';



void main() {
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



  void addTask({String? title,int? priority,String? endDate}){
    todoLists.add(TodoModel(title: title,priority: priority,dateEndTime:endDate ));
  }

  List<TodoModel> getTasks(){
    return todoLists;
  }


}


