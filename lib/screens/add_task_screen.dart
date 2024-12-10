import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/utils/database_helper.dart';
import 'package:todo/utils/styles.dart';
import 'package:intl/intl.dart';
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



  TextEditingController myDateController = TextEditingController();
  TextEditingController controller = TextEditingController();
  int priority = 2;


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
        myDateController.text=picker.toString();
      }
    }
    void clearTextField(){
      controller.clear();
      myDateController.clear();
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
                          value: 2,
                          items: [
                            DropdownMenuItem(child: Text('High'),value: 2,),
                            DropdownMenuItem(child: Text('Low'),value: 1,),
                          ], onChanged: (value){
                        setState(() {
                          priority = value??2;
                        });
                      })
                    ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
                  width: 150,
                  child: TextField(
                    readOnly: true,
                    controller: myDateController,
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
                      // insertDataInDB();
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



