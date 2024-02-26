// ignore_for_file: unused_local_variable, constant_identifier_names, non_constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wslc_226_datbase/models/notes_model.dart';

class DbHelper {
  //private constructor
  DbHelper._();

  static final DbHelper db = DbHelper._();

  Database? _dataBase;

  static const Note_table = 'note_table';
  static const Column_Id = 'note_id';
  static const Column_Title = 'note_title';
  static const Column_Desc = 'note_desc';

  Future<Database> getDb() async {
    if (_dataBase != null) {
      return _dataBase!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "noteDB.db");
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(
          "Create table $Note_table ( $Column_Id integer primary key autoincrement, $Column_Title text, $Column_Desc text )");
    });
  }

  Future<void> addNotes(Notes_Model newNotes) async{
      var db = await getDb();
      await db.insert(Note_table, newNotes.toMap());
  }

  Future<List<Notes_Model>> fetchAllData() async{
    var db = await getDb();
    List<Map<String,dynamic>> notes = await db.query(Note_table);
    List<Notes_Model> Listnotes = [];

        for(Map<String,dynamic> note in notes){
          Notes_Model model = Notes_Model.fromMap(note);
          Listnotes.add(model);
        }
        return Listnotes;
  }

  Future<void> updateNotes (Notes_Model notes_model) async{
     var db = await getDb();
     await db.update(Note_table, notes_model.toMap(),
     where: "$Column_Id = ${notes_model.id}"
     );
  }

  Future<void> deleteNotes (int id) async{
    var db = await getDb();
    await db.delete(Note_table, where: "$Column_Id = $id");
  }

}
