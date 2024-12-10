//Todo data model
class TodoModel{
  late int? id;
  late String? title;
  late int? priority;
  late String? dateEndTime;
  late bool? isChecked=false;

  //Constructor to call
  TodoModel({this.title,this.priority,this.dateEndTime,this.isChecked});



//Converting to map
// Map<String,dynamic> toMap(){
//   var map = Map<String,dynamic>();
//   if(id!=null){
//     map['id']=id;
//   }
//   map['title']=title;
//   map['priority']=priority;
//   map['dateEndTime']=dateEndTime;
//   map['isChecked']=isChecked;
//
//   return map;
// }

//from map to variable
// TodoModel.fromMap(Map<String,dynamic> map){
//   this.id = map['id'];
//   this.title = map['title'];
//   this.priority = map['priority'];
//   this.dateEndTime = map['dateEndTime'];
//   this.isChecked = map['isChecked'];
//
// }

}