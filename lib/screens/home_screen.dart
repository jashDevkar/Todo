import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/task_list.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/utils/styles.dart';


//whole app is divided into 2 sections home screen and add task screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box _box = Hive.box('mybox');

  @override
  void initState() {
    //Checking if any item is present in local storage or not
    if (_box.get('TODOS') == null) {
      //if no items are present than this will add 2 items in list
      Provider.of<TodoData>(context, listen: false).intializeDataBase();
    }else{
      Provider.of<TodoData>(context, listen: false).getAllTasks();
    }
    super.initState();
  }

  //radio selector
  String? selectedValue='All tasks' ;


  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<TodoData>(context,listen: false);
    return Scaffold(
      // Drawer where filtering options are present
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    'F I L T E R',
                    style: kFilterTextStyle,
                  ),
                ),
              ),

             //radio for all task
             ListTile(
               title: const Text('All Tasks'),
               trailing: Radio(
                 value: 'All tasks',
                 groupValue: selectedValue,
                 onChanged: (value){
                   Provider.of<TodoData>(context,listen: false).getAllData();
                   setState(() {
                     selectedValue=value;
                   });
                 },
               ),
             ),

             //radio for completed task
             ListTile(
                title: Text('Completed Task'),
                trailing: Radio(
                  value: 'Completed Task',
                  groupValue: selectedValue,
                  onChanged: (value){
                    Provider.of<TodoData>(context,listen: false).getCompletedTask();
                    setState(() {
                      selectedValue=value;
                    });
                  },
                ),
              ),

             //radio for high priority task
             ListTile(
                title: Text('High Priority task'),
                trailing: Radio(
                  value: 'High Priority',
                  groupValue: selectedValue,
                  onChanged: (value){
                    Provider.of<TodoData>(context,listen: false).getHighPriorityTasks();
                    setState(() {
                      selectedValue=value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.menu),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),

      //Add icon (+) press to add a task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Todo',
                  style: kTitleTextStyle,
                ),
                Text(
                  '${Provider.of<TodoData>(context).getCount()} Tasks',
                  style: kTaskCountStyle,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: const TaskList(),
            ),
          )
        ],
      ),
    );
  }
}
