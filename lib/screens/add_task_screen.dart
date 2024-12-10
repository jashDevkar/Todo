import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/styles.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {

   const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {


  @override
  void initState(){
    super.initState();

  }

  TextEditingController endDateController = TextEditingController();
  TextEditingController controller = TextEditingController();

  String? priority = 'low';


  @override
  Widget build(BuildContext context) {



    Future<void> getDate(context)async{
      DateTime? picker = await showDatePicker(
          context: context,
          currentDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025)
      );

      if(picker!=null){
        endDateController.text=picker.toString();
      }
    }
    void clearTextField(){
      controller.clear();
      endDateController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add data',style: kAddTaskScreenAppBar,),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value){},
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter your data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: [
                      Text('Priority'),
                      SizedBox(width: 10.0,),
                      DropdownButton(
                          value: priority,
                          items: [
                            const DropdownMenuItem(child: Text('High'),value: 'high',),
                            const DropdownMenuItem(child: Text('Low'),value: 'low',),
                          ],
                          onChanged: (value){
                          setState(() {
                            priority = value;
                          });
                      })
                    ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
                  width: 150,
                  child: TextField(
                    readOnly: true,
                    controller: endDateController,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.date_range)
                    ),
                    onTap: (){
                      getDate(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ))
                    ),
                    onPressed: (){

                       Provider.of<TodoData>(context,listen: false).addTask(title: controller.text,priority: priority,endDate: endDateController.text,);
                     Navigator.pop(context);
                    },
                    child: const Text('submit',style: TextStyle(color: Colors.white),),),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(Colors.red),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ))
                    ),
                    onPressed: (){
                      clearTextField();
                    },
                    child: Text('clear',style: TextStyle(color: Colors.white),),),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}



