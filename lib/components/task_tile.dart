import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/styles.dart';

class TaskTile extends StatelessWidget {
  late String title;
  Function onCheckChanged;
  bool isChecked;
  late String priority;
  late int position;
  late String dateEndTime;

  TaskTile(
      {required this.position,
      required this.priority,
      required this.title,
      required this.isChecked,
      required this.onCheckChanged,
        required this.dateEndTime
      });


  //checking whether the the due date has passed or not
  String getDueDateText(){
    DateTime date1 = DateTime.now();
    DateTime date2   = DateTime.parse(dateEndTime);
    var day = date2.day;
    var year = date2.year;
    if(date2.isAfter(date1)){
      return 'Upcoming $day/$year';
    }
    else{
      return 'Passed $day/$year';
    }


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Provider.of<TodoData>(context, listen: false).deleteTask(position);
      },
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0,top: 10.0,bottom: 10.0,right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Conditional rendering for high priority task
                      if (priority == 'high')
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration:isChecked ? TextDecoration.lineThrough : null
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                  Text(getDueDateText()),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      onCheckChanged(value);
                    },
                  ),
                  const SizedBox(width: 10.0,),
                  GestureDetector(
                    child: Icon(Icons.edit),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
