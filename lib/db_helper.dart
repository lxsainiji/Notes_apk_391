

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  DBHelper._();
  static DBHelper getInstance(){
    return DBHelper._();
  }

  Database? db;
  String tableName ="notes";
  static String columnNoteId="note_id";
  static final String columnNoteTitle="note_title";
  static final String columnNoteDes="note_des";
  static final String columnCreatedAt="created_at";

  Future<Database> initDb() async {
    if(db==null){
      db=await openDb();
      return db!;
    }
    else{
      return db!;
    }
  }


  Future<Database> openDb()async{
    Directory mDir =await getApplicationDocumentsDirectory();
    String actualPath =join(mDir.path,"Notes.db");
    return openDatabase(actualPath,version: 1,onCreate: (db,version){
      db.execute("create table $tableName($columnNoteId integer primary key autoincrement,$columnNoteTitle text,$columnNoteDes text,$columnCreatedAt text)");
    });
  }

  Future<bool> add({required String title,required String des})async{
    var db=await initDb();
    int rowAffected =await db.insert(tableName, {
      columnNoteTitle:title,
      columnNoteDes:des,
      columnCreatedAt:DateTime.now().millisecondsSinceEpoch.toString()
    });
    return rowAffected>0;
  }

  Future<List<Map<String, dynamic>>> fetchNotes()async{
    var db=await initDb();
    return db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> editView({required int id}) async {
    var db = await initDb();
    return await db.query(
      tableName,
      where: '$columnNoteId = ?',
      whereArgs: [id],
    );
  }


  Future<bool> updateNote({required String title,required String des,required int id})async{
    var db=await initDb();
    int rowAffected =await db.update(
        tableName,{
      columnNoteTitle:title,
      columnNoteDes:des,
      columnCreatedAt:DateTime.now().millisecondsSinceEpoch.toString()
      },
      where: "$columnNoteId = ?",
      whereArgs: [id]
    );
    return rowAffected>0;
  }

  Future<bool> deleteNote({required int id})async{
    var db=await initDb();
    var rowAffected =await db.delete(tableName,where: "$columnNoteId = $id");
    return rowAffected>0;
  }
}






// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper {
//   DBHelper._();
//   static DBHelper getInstance(){
//     return DBHelper._();
//   }
//
//   Database? db;
//   String tableName="Notes";
//   static final String columnNoteId="note_id";
//   static final String columnNoteTitle="note_title";
//   static final String columnNoteDes="note_des";
//   static final String columnNoteCreatedAt="created_at";
//
//   Future<Database> initDB() async {
//     if(db==null){
//       db = await openDB();
//       return db!;
//     }
//     else{
//       return db!;
//     }
//   }
//
//   Future<Database> openDB()async{
//     Directory mDir=await getApplicationDocumentsDirectory();
//     String actualPath =join(mDir.path,"Notes.db");
//
//     return openDatabase(actualPath,version: 1,onCreate: (db,version){
//       db.execute("create table $tableName ($columnNoteId integer primary key autoincrement, $columnNoteTitle text, $columnNoteDes text, $columnNoteCreatedAt text)");
//     });
//   }
//
//   //////Add
//   Future<bool> addNote({required String title,required String des})async{
//     var db=await initDB();
//     int affectedRow = await db.insert(tableName, {
//       columnNoteTitle:title,
//       columnNoteDes:des,
//       columnNoteCreatedAt:DateTime.now().millisecondsSinceEpoch.toString()
//     });
//     return affectedRow > 0;
//   }
//
//   //Fetch
//   Future<List<Map<String, dynamic>>> fetchNotes()async{
//     var db =await initDB();
//     return db.query(tableName);
//   }
//
//   //viewNotes
//
//   Future<String> viewNote({required int indx}) async {
//     var db = await initDB();
//     indx++;
//     var result = await db.query(
//       tableName,
//       columns: [columnNoteDes],
//       where: '$columnNoteId = ?',
//       whereArgs: [indx],
//     );
//
//     if (result.isNotEmpty) {
//       return result.first[columnNoteDes].toString();
//     } else {
//       return "Note not found";
//     }
//   }
//
//
//
//   void updateNote({required int indx,required String des}) async {
//     var db = await initDB();
//     indx++;
//     db.update(
//       tableName,
//       {
//         columnNoteDes:des,
//       },
//       where: '$columnNoteId = ?',
//       whereArgs: [indx],
//     );
//
//     // if (result.isNotEmpty) {
//     //   return result.first[columnNoteDes].toString();
//     // } else {
//     //   return "Note not found";
//     // }
//   }
//
// }