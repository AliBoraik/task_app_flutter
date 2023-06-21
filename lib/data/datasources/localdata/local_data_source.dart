import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/exception.dart';
import '../../models/task.dart';
import 'database_helper.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> getAllTaskModelsLocal();
  Future<TaskModel> addTaskModelToLocal(TaskModel task);
  Future<void> updateTaskModel(TaskModel task);
  Future<void> deleteAllTasks();
  Future<void> deleteTask(String id);
  Future<void> saveName(String name);
  Future<void> removeName();
  Future<String> getName();
}

class LocalDataSourceImpl extends LocalDataSource {
  DatabaseHelper databaseHelper;
  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TaskModel>> getAllTaskModelsLocal() async {
    await databaseHelper.open();
    List<TaskModel> taskModels = await databaseHelper.getAllTaskModels();
    if (taskModels.isEmpty) throw CacheException();
    return taskModels;
  }

  @override
  Future<TaskModel> addTaskModelToLocal(TaskModel task) async {
    await databaseHelper.open();
    int result = await databaseHelper.insert(task);
    if (result == -1) throw CacheException();
    return task;
  }

  @override
  Future<void> deleteAllTasks() async {
    await databaseHelper.drugDatabase();
  }

  @override
  Future<void> deleteTask(String id) async {
    int result = await databaseHelper.delete(id);
    if (result == -1) throw CacheException();
  }

  @override
  Future<void> updateTaskModel(TaskModel task) async {
    await databaseHelper.update(task);
  }

  @override
  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('userName', name);
    if (!result) {
      throw CacheException();
    }
  }

  @override
  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();

    String? userName = prefs.getString('userName');
    if (userName == null) {
      throw CacheException();
    }
    return userName;
  }

  @override
  Future<void> removeName() async {
    final prefs = await SharedPreferences.getInstance();

    bool userName = await prefs.clear();
    if (!userName) {
      throw CacheException();
    }
  }
}
