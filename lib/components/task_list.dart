import 'package:flutter/material.dart';
import 'package:todo/components/task_tile.dart';

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

  List myData = [
    ['1st Task',false],
    ['2st Task',false],
  ];

  void alterIsChecked(index,value){
    setState(() {
      myData[index][1] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myData.length,
        itemBuilder:(context,position){
          return (
          TaskTile(
            taskName: myData[position][0],
            isChecked: myData[position][1],
            onCheckChanged: (value){
              alterIsChecked(position, value);
            },
          )
          );
        }
    );

  }
}

