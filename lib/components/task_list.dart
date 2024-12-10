import 'package:flutter/material.dart';
import 'package:todo/utils/database_helper.dart';
import 'package:todo/model/task_model.dart';
class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  DBHelper? dbHelper;
  late Future<List<TodoModel>> data  ;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData()async{
    data = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return 
        FutureBuilder(
            future: data,
            builder: (context,AsyncSnapshot<List<TodoModel>> snapshot) {

              if(!snapshot.hasData || snapshot.data == null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.data!.length == 0){
                return Center(
                  child: Text('No data present'),
                );
              }
              else{
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                    itemBuilder: (context,int){

                    });
              }

        }
      );
    }
  }

