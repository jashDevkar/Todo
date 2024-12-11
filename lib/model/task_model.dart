//Todo data model
class TodoModel {
  late int? id;
  late String? title;
  late String priority='low';
  late String dateEndTime;
  late bool isChecked = false;

  //Constructor to call
  TodoModel(
      {required this.title, required this.priority, required this.dateEndTime, required this.isChecked });


  //converting objects to map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateEndTime': dateEndTime,
      'isChecked': isChecked,
      'priority': priority,
    };
  }


  //converting Map to objects
  factory TodoModel.fromJson( var item) {
    return TodoModel(
      title: item['title'],
      dateEndTime: item['dateEndTime'], // Parse string to DateTime or keep null
      isChecked: item['isChecked'] ?? false,
      priority: item['priority'],
    );
  }
}







