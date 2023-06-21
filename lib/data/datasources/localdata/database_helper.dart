import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/task.dart';

class DatabaseHelper {
  final String _databaseName = "database.db";
  final int _databaseVersion = 1;
  final String _tableName = "tasks";
  late Database _database;

  Future<void> open() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, title TEXT, description TEXT,color INTEGER,dateTime INTEGER,icon INTEGER, is_completed INTEGER)',
        );
      },
      version: _databaseVersion,
    );
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<int> insert(TaskModel task) async {
    return await _database.insert(
      _tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(TaskModel task) async {
    await _database.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(String id) async {
    return await _database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskModel>> getAllTaskModels() async {
    List<Map<String, dynamic>> maps = await _database.query(_tableName);
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  // Define a function to delete the database file
  Future<void> drugDatabase() async {
    String path = await getDatabasesPath();
    await deleteDatabase(join(path, _databaseName));
  }
}
