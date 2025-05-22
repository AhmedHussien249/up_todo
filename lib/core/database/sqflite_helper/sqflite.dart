// import 'dart:developer';
//
// import 'package:sqflite/sqflite.dart';
//
// import '../../../features/task/data/model/task_model.dart';
//
// class SqfLiteHelper {
//   late Database db;
//
//   //* create DataBase
//   //* create table
//   //* create crud => insert , update , delete , read
//
//   //! init database
//   Future<void> initDB() async {
//     //? step 1 : create database
//     await openDatabase(
//       'tasks.db',
//       version: 1,
//       onCreate: (Database db, version) async {
//         await db
//             .execute('''
//     CREATE TABLE tasks(
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     title TEXT,
//     note TEXT,
//     date TEXT,
//     startTime TEXT,
//     endTime TEXT,
//     color INTEGER,
//     isCompleted INTEGER
//     )
//     ''')
//             .then((value) => log('table created successfully'));
//       },
//       onOpen: (db) {
//         log('Database Open');
//       },
//     ).then((value) => db = value).catchError((e) {
//       log(e.toString());
//       return Future.value(db);
//     });
//     // step 2 : create table
//   }
//
//   //! get
//   Future<List<Map<String, dynamic>>> getTasks() async {
//     return await db.rawQuery('Select * from tasks');
//   }
//
//   //! insert
//   Future<int> insertToTasks(TaskModel model) async {
//     return await db.rawInsert('''
//     INSERT INTO tasks(
//     title,note,date,startTime,endTime,color,isCompleted,)
//     VALUES(
//     ${model.title},${model.note},${model.date},${model.startTime},
//     ${model.endTime},${model.color},${model.isCompleted}
//     ''');
//   }
//
//   //! update
//   Future<int>updateTask(int id) async{
//     return await db.rawUpdate(
//       '''
//     UPDATE tasks
//     SET isCompleted = ?
//     WHERE id = ?
//     ''',
//       [1, id],
//     );
//   }
//   //! delete
//   Future<int> deleteTask(int id) async {
//    return await db.rawDelete(
//       '''
//     DELETE FROM tasks
//     WHERE id = ?
//     ''',
//       [id],
//     );
//   }
// }

import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../features/task/data/model/task_model.dart';

class SqfLiteHelper {
  late Database db;

  //1. create DB
  //2.create table
  //3.CRUD => create - read - update - delete

  //! initDatabase
  Future<void> initDB() async {
    //step 1 => Create database
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        //step 2 => create table
        return await db
            .execute('''
      CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT ,
        title TEXT,
        note TEXT,
        date TEXT,
        startTime TEXT,
        endTime TEXT,
        color INTEGER,
        isCompleted INTEGER )
      ''')
            .then((value) => log('DB created successfully'));
      },
      onOpen: (db) => log('Database opened'),
    ).then((value) => db = value);
  }

  //!get
  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //! insert
  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert('''
      INSERT INTO Tasks( 
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
         VALUES
         ('${model.title}','${model.note}','${model.date}','${model.startTime}',
       '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }

  //! update
  Future<int> updatedDB(int id) async {
    return await db.rawUpdate(
      '''
    UPDATE Tasks
    SET isCompleted = ?
    WHERE id = ?
   ''',
      [1, id],
    );
  }

  //! delete
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete('''DELETE FROM Tasks WHERE id = ?''', [id]);
  }
}
