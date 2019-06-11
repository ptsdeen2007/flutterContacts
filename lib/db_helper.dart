import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//import 'dart:async';


import 'constants.dart';
import 'model.dart';

class DatabaseHelper{
  static final DatabaseHelper _INSTANCE = new DatabaseHelper.make();

  factory DatabaseHelper() => _INSTANCE;

  static Database _db;

  DatabaseHelper.make();

  //init db

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, Constants.DBNAME);
    var myDb =
    openDatabase(path, version: Constants.DB_VERSION, onCreate: _onCreate);

    return myDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE ${Constants.TABLE_NAME} (${Constants.COL_NAME} TEXT, "
            "${Constants.COL_PLACE} TEXT, ${Constants.COL_PATH} TEXT );");
  }
//insert path
  Future<int> insertNote(Contacts contacts) async {
    var dbClient = await db;
    int count = await dbClient.insert(Constants.TABLE_NAME, contacts.toMap());

    return count;
  }

  //get contacts
  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM ${Constants.TABLE_NAME}");
    return result.toList();
  }
}