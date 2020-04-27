import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'task.dart';
import 'dart:collection';

class DatabaseProvider extends ChangeNotifier {
  DatabaseProvider._();

  static final DatabaseProvider dbProvider = DatabaseProvider._();
  Database _database;

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  List<Task> _tasks = [];

  void updateTasks() async {
    _tasks = await fetchTasks();
    notifyListeners();
  }

  int tasksCount() {
    return tasks.length;
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      is_done INTEGER)
  ''');
    print("Database was created!");
  }

  Future<int> addTask(Task task) async {
    var client = await db;
    var result = client.insert('tasks', task.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    updateTasks();
    return result;
  }

  Future<List<Task>> fetchTasks() async {
    var client = await db;
    var result = await client.query('tasks');

    if (result.isNotEmpty) {
      var tasks = result.map((taskMap) => Task.fromDb(taskMap)).toList();
      return tasks;
    }
    return [];
  }

  Future<void> updateTask(Task task) async {
    var client = await db;
    task.toggleDone();
    client.update('tasks', task.toMapForDb(),
        where: 'id = ?',
        whereArgs: [task.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    updateTasks();
  }

  Future<void> removeTask(Task task) async {
    var client = await db;
    var id = task.id;
    client.delete('tasks', where: 'id = ?', whereArgs: [id]);
    updateTasks();
  }
}
