import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDBHelper{

  var NOTE_TABLE = "simpleNote";
  var NOTE_ID = "note_id";
  var NOTE_TITLE = "note_title";
  var NOTE_DESC = "note_desc";

  Future<Database> openDb() async{
    var mDirectory = await getApplicationDocumentsDirectory();
    await mDirectory.create(recursive: true);
    var dbpath = "$mDirectory/simpleNote.db";

    return await openDatabase(dbpath, version: 1, onCreate: (db, version){

      var createTableQuery =
          "create table $NOTE_TABLE ($NOTE_ID integer primary key autoincrement, $NOTE_TITLE text, $NOTE_DESC text)";
      db.execute(createTableQuery);

    });

  }

  Future<bool> addNote(String id, String title, String desc) async {
    var db = await openDb();
    var check = await db
        .insert(NOTE_TABLE, {NOTE_ID:id, NOTE_TITLE: title, NOTE_DESC: desc});
    return check > 0;
  }

  Future<List<Map<String, dynamic>>> fetchAllNotes() async {
    var db = await openDb();
    List<Map<String, dynamic>> notes = await db.query(NOTE_TABLE);
    return notes;
  }

  Future<bool> updateNote(String id, String title, String desc) async {
    var db = await openDb();
    var check = await db.update(
        NOTE_TABLE, {NOTE_TITLE: title, NOTE_DESC: desc},
        where: "$NOTE_ID = $id");
    return check > 0;
  }

  Future<bool> deleteNote(String id) async {
    var db = await openDb();
    var check = await db
        .delete(NOTE_TABLE, where: "$NOTE_ID = ?", whereArgs: [id]);
    return check > 0;
  }

}