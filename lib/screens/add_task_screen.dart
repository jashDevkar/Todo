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


  TextEditingController endDateController = TextEditingController();
  TextEditingController controller = TextEditingController();

  String priority = 'low';


  @override
  Widget build(BuildContext context) {



    //pick a date from date selecter
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

    //clear controller after adding your task
    void clearTextField(){
      controller.clear();
      endDateController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add data',style: kAddTaskScreenAppBar,),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          children: [
            //input field for task
            TextField(
              onChanged: (value){},
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter your task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //priority field
                Row(
                    children: [
                      //select priority from dropDown menu
                      const Text('Priority'),
                      const SizedBox(width: 10.0,),
                      DropdownButton(
                          value: priority,
                          items: const [
                            DropdownMenuItem(child: Text('High'),value: 'high',),
                            DropdownMenuItem(child: Text('Low'),value: 'low',),
                          ],
                          onChanged: (value){
                          setState(() {
                            priority = value?? 'low';
                          });
                      })
                    ]
                ),
                //date input field
                Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
                  width: 150,
                  child: TextField(
                    readOnly: true,
                    controller: endDateController,
                    decoration: const InputDecoration(
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
                //add task button
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ))
                    ),
                    onPressed: (){
                      //check if all fields are entered or not
                       if(controller.text!= "" && endDateController.text!= ""){
                         Provider.of<TodoData>(context,listen: false).addTask(title: controller.text,priority: priority,endDate: endDateController.text,);
                         clearTextField();
                         Navigator.pop(context);
                       }
                       else{
                         //show alert when one of the field is missing
                          dialogBuilder(context);

                       }

                    },
                    child: const Text('Add Task',style: TextStyle(color: Colors.white),),),
                ),
                const SizedBox(width: 10.0,),
                //clear button
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
                    child: const Text('clear',style: TextStyle(color: Colors.white),),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


Future<void> dialogBuilder(context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('All fields are needed'),
      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('ok'))
      ],
    );
  });
}






