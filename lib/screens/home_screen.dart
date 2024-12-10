import 'package:flutter/material.dart';
import 'package:todo/components/task_list.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
      ),
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30.0,top: 60,bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(child:Icon(Icons.menu),backgroundColor: Colors.white,),
                SizedBox(height: 10.0,),
                Text('Todo',style: kTitleTextStyle,),
                Text('Tasks',style: kTaskCountStyle,)
              ],
            ),
          ),
          Expanded(
              child:Container(
                padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
                decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: TaskList(),
          ),
          )
        ],
      ),
    );
  }
}
