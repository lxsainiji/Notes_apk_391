import 'package:flutter/cupertino.dart';
import 'package:notes/db_helper.dart';

class NotesProvider extends ChangeNotifier{
  DBHelper varDb;
  NotesProvider({required this.varDb});

  List<Map<String,dynamic>> _getAllData=[];
  List<Map<String,dynamic>> _editData=[];

  List<Map<String,dynamic>> getData()=>_getAllData;
  List<Map<String,dynamic>> getEdit()=>_editData;

  fetchInitData()async{
    _getAllData=await varDb.fetchNotes();
    notifyListeners();
  }

  add({required String title,required String des})async{
    bool check =await varDb.add(title: title, des: des);
    if(check){
      _getAllData=await varDb.fetchNotes();
      notifyListeners();
    }
  }

  editView({required int id})async{
      _editData =await varDb.editView(id: id);
      notifyListeners();
  }

  updateNote({required String title,required String des,required int id})async{
    bool check=await varDb.updateNote(title: title, des: des, id: id);
    if(check){
      _getAllData=await varDb.fetchNotes();
      notifyListeners();
    }
  }

  deleteNote({required int id})async{
    bool check=await varDb.deleteNote(id: id);
    if(check){
      _getAllData=await varDb.fetchNotes();
      notifyListeners();
    }
  }

}