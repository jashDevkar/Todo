//Todo data model
class TodoModel {
  late int? id;
  late String? title;
  late String? priority;
  late String? dateEndTime;
  late bool isChecked = false;

  //Constructor to call
  TodoModel(
      {required this.title, this.priority, required this.dateEndTime, required this.isChecked });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateEndTime': dateEndTime, // Convert DateTime to String
      'isChecked': isChecked,
      'priority': priority,
    };
  }


  factory TodoModel.fromJson( var item) {
    return TodoModel(
      title: item['title'],
      dateEndTime: item['dateEndTime'], // Parse string to DateTime or keep null
      isChecked: item['isChecked'] ?? false,
      priority: item['priority'],
    );
  }
}



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

