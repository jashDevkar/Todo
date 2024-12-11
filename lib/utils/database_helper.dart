// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:t;
//
// class DBHelper{
//
//   static late DBHelper _databaseHelper;  //signleton instance
//
//   // DBHelper._createInstance();  //named constructor
//   static  Database? _db;
//
//
//   Future<Database?> get db async{
//     if(_db!=null){
//       return _db;
//     }
//     _db = await intitDatabase();
//     return null;
//   }
//
//   Future<Database> intitDatabase()async{
//     Directory directory= await getApplicationDocumentsDirectory();
//     String path  = directory.path + 'task.db';
//
//     var db = openDatabase(path,version: 1,onCreate: _createDB);
//
//     return db;
//   }
//
//   void _createDB(Database db,int newVersion)async{
//     await db.execute('CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,'
//         'priority INTEGER,dateEndTime TEXT,isChecked BOOLEAN)');
//   }
//
//
//
//   // Insert Operation: Insert a Note object to database
//   Future<int?> insertTask(TodoModel task) async {
//     var dbClient = await this.db;
//     var result = await dbClient?.insert('mytodo', TodoModel().toMap());
//     return result;
//   }
//
//   // Update Operation: Update a Note object and save it to database
//   Future<int?> updateTask(TodoModel todoModel) async {
//     var dbClient = await this.db;
//     var result = await dbClient!.update('mytodo', todoModel.toMap(), where: 'id = ?', whereArgs: [todoModel.id]);
//     return result;
//   }
//
//   // Delete Operation: Delete a Note object from database
//   Future<int> deleteTask(int id) async {
//     var dbClient = await db;
//     int result = await dbClient!.delete('mytodo',where: 'id=?',whereArgs: [id]);
//     return result;
//   }
//
//
//
//   // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
//   Future<List<TodoModel>> getDataList() async {
//
//     await db;
//     final List<Map<String,dynamic>> QueryResult = await _db!.rawQuery('SELECT * FROM mytodo');
//     return QueryResult.map((e)=>TodoModel.fromMap(e)).toList();
//
//
//   }
//
//
// }
//
//
//
//
//
// //   Future<List<Map<String, dynamic>>> getNoteMapList() async {
// //     var  dbClient = await db;
// //
// // //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
// //     var result = await db.query(taskTable, orderBy: '$colPriority ASC');
// //     return result;
// //   }
//
//
// // Get number of Note objects in database
// // Future<int?> getCount() async {
// //   Database db = await this.database;
// //   List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $taskTable');
// //   int? result = Sqflite.firstIntValue(x);
// //   return result;
// // }


// sql data base but hive is used in this project