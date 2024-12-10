import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';

class TaskTile extends StatelessWidget {

  late String taskName;
  Function onCheckChanged;
  late bool isChecked;

   TaskTile({
    required this.taskName,
    required this.isChecked,
    required this.onCheckChanged
});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                 Icon(Icons.star),
                 SizedBox(width: 10.0,),
                 Column(
                   children: [
                     Text('My title',style:TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       decoration:isChecked? TextDecoration.lineThrough: null
                     ),),
                     Text('Description')
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
    );
  }
}
