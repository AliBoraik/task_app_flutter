import 'package:dartz/dartz.dart';
import 'package:task/domain/usecases/get_name.dart';
import 'package:task/domain/usecases/remove_task.dart';
import 'package:task/domain/usecases/save_name.dart';
import 'package:task/domain/usecases/update_task.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../models/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_all_task.dart';
import '../../domain/usecases/get_all_tasks.dart';

abstract class TaskController {
  Future<Either<Failure, List<TaskModel>>> getAll();
  Future<Either<Failure, TaskModel>> addTaskModel(TaskModel task);
  Future<Either<Failure, TaskModel>> updateTaskModel(TaskModel task);
  Future<Either<Failure, Ok>> deleteAll();
  Future<Either<Failure, Ok>> deleteTaskModel(String id);
  Future<Either<Failure, Ok>> saveUserName(String id);
  Future<Either<Failure, String>> getUserName();
}

class TaskControllerImpl extends TaskController {
  final GetAllTasks getAllTasks;
  final AddTask addTask;
  final DeleteAllTasks deleteAllTasks;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;
  final SaveName saveName;
  final GetName getName;

  TaskControllerImpl({
    required this.getAllTasks,
    required this.addTask,
    required this.deleteAllTasks,
    required this.deleteTask,
    required this.updateTask,
    required this.saveName,
    required this.getName,
  });

  @override
  Future<Either<Failure, TaskModel>> addTaskModel(TaskModel task) async {
    return await addTask.call(task);
  }

  @override
  Future<Either<Failure, Ok>> deleteAll() async {
    return await deleteAllTasks.call(NoParams());
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAll() async {
    return await getAllTasks.call(NoParams());
  }

  @override
  Future<Either<Failure, Ok>> deleteTaskModel(String id) async {
    return await deleteTask.call(id);
  }

  @override
  Future<Either<Failure, TaskModel>> updateTaskModel(TaskModel task) async {
    return await updateTask.call(task);
  }

  @override
  Future<Either<Failure, String>> getUserName() async {
    return await getName.call(NoParams());
  }

  @override
  Future<Either<Failure, Ok>> saveUserName(String id) async {
    return await saveName.call(id);
  }
}
