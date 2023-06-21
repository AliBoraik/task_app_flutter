import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks();
  Future<Either<Failure, TaskModel>> addTask(TaskModel task);
  Future<Either<Failure, TaskModel>> updateTask(TaskModel task);
  Future<Either<Failure, Ok>> deleteAllTasks();
  Future<Either<Failure, Ok>> deleteTask(String id);
  Future<Either<Failure, Ok>> saveName(String id);
  Future<Either<Failure, String>> getName();
}
