import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/styles.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {

  String title;
  String dateEndTime;
  String priority;
  bool isChecked;
  int position;

  AddTaskScreen({required this.title,required this.priority,required this.isChecked,required this.dateEndTime,required this.position});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {


  TextEditingController endDateController = TextEditingController();
  TextEditingController controller = TextEditingController();





  @override
  Widget build(BuildContext context) {
    endDateController.text = widget.dateEndTime;
    controller.text = widget.title;
    var priority = widget.priority;
    var position = widget.position;

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
        title: const Text('Add data',style: kAddTaskScreenAppBar,),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
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
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ))
                    ),
                    onPressed: (){

                      Provider.of<TodoData>(context,listen: false).updateTask(title: controller.text,priority: priority,position:position,dateEndTime: endDateController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('update',style: TextStyle(color: Colors.white),),),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}



