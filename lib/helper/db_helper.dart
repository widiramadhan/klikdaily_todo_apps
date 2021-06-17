import 'dart:async';
import 'dart:io';

import 'package:apps_todo/model/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'todo_klikdaily.db');
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS todo");
    _onCreate(db, newVersion);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo (todo_id INTEGER PRIMARY KEY AUTOINCREMENT, category_id INT, title TEXT, note TEXT, date TEXT, status INT)');
  }

  Future<bool> addTodo(TodoModel todoModel) async {
    var dbClient = await db;
    int insert = await dbClient.insert('todo', todoModel.toMap());
    print(insert);
    if(insert != 0){
      return true;
    }else{
      return false;
    }
  }

  Future<List<TodoModel>> getTodoById(int categoryId) async {
    var dbClient = await db;
    List<Map> mapsTodo = await dbClient.query('todo', where: 'category_id = ${categoryId}');
    List<TodoModel> todos = [];
    if (mapsTodo.length > 0) {
      for (int j = 0; j < mapsTodo.length; j++) {
        todos.add(TodoModel.fromMap(mapsTodo[j]));
      }
    }
    return todos;
  }

  Future<bool> updateStatus(int todo_id, int status) async {
    var dbClient = await db;
    int sts = 0;
    if(status == 1){
      sts = 2;
    }else{
      sts = 1;
    }

    int exec = await dbClient.rawUpdate("update todo set status=$sts where todo_id=$todo_id");
    if(exec == 1) {
      return true;
    }else{
      return false;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
