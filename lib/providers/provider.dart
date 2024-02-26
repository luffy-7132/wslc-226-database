import 'package:flutter/material.dart';
import 'package:wslc_226_datbase/app_database/app_database.dart';
import 'package:wslc_226_datbase/models/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  List<Notes_Model> arrNotes = [];

  DbHelper db = DbHelper.db;

  ///fetch All data when app is open
  fetchInitialNotes() async {
    arrNotes = await db.fetchAllData();
    notifyListeners();
  }

  ///get Notes
  List<Notes_Model> getNotes() {
    fetchInitialNotes();
    return arrNotes;
  }

  ///Add Notes
  addNotes(Notes_Model newNotes) async {
    await db.addNotes(newNotes);
    arrNotes = await db.fetchAllData();
    notifyListeners();
  }

  /// Update Notes
  updateNotes(Notes_Model notes_model) async {
    await db.updateNotes(notes_model);
    arrNotes = await db.fetchAllData();
    notifyListeners();
  }

  /// delete Notes
  deleteNotes(int id) async {
    await db.deleteNotes(id);
    arrNotes = await db.fetchAllData();
    notifyListeners();
  }
}
