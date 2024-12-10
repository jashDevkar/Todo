import 'package:flutter/material.dart';
import 'package:todo/components/task_tile.dart';
import 'package:todo/main.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/add_task_screen.dart';




class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  @override
  void initState() {
    super.initState();
  }



  void alterIsChecked(position,value){
    setState(() {
      Provider.of<TodoData>(context,listen: false).checkTask(position,value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoData>(
      builder: (context,todoData,child){
      return ListView.builder(
        itemCount: todoData.todoLists.length,
          itemBuilder:(context,position){
            final dataTile=todoData.todoLists[position];
            return (
            TaskTile(
              title: dataTile.title.toString(),
              isChecked:dataTile.isChecked,
              priority: dataTile.priority.toString(),
              position: position,
              onCheckChanged: (value){
                alterIsChecked(position, value);
              },
            )
            );
          }
      );
      }
    );


  }
}

