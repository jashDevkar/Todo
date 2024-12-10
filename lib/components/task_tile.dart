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

   TaskTile({
    required this.position,
     required this.priority,
     required this.title,
     required this.isChecked,
     required this.onCheckChanged
});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
          Provider.of<TodoData>(context,listen: false).deleteTask(position);
      },
      child: Card(
        color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                 children: [
                   if(priority =='high')
                     Icon(Icons.star,color: Colors.yellow,),
                   SizedBox(width: 10.0,),
                   Column(
                     children: [
                       Text('${this.title}',style:TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         decoration:isChecked ? TextDecoration.lineThrough: null
                       ),),

                     ],
                   ),
                 ],
               ),

                Checkbox(value: isChecked, onChanged: (value){
                  onCheckChanged(value);
                })
              ],
            ),
          ),
      ),
    );
  }
}
