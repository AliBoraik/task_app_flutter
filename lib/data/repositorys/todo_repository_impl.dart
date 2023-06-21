import 'package:dartz/dartz.dart';

import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/localdata/local_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks() async {
    try {
      var localTaskModels = await localDataSource.getAllTaskModelsLocal();
      return Right(localTaskModels);
    } on CacheException {
      return const Left(CacheFailure("error in getAllTasks!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel task) async {
    try {
      var localTaskModels = await localDataSource.addTaskModelToLocal(task);
      return Right(localTaskModels);
    } on CacheException {
      return const Left(CacheFailure("Local Error!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, Ok>> deleteAllTasks() async {
    try {
      await localDataSource.deleteAllTasks();
      return Right(Ok());
    } on CacheException {
      return const Left(CacheFailure("Local Error!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, Ok>> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      return Right(Ok());
    } on CacheException {
      return const Left(CacheFailure("Cannot remove!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTask(TaskModel task) async {
    try {
      await localDataSource.updateTaskModel(task);
      return Right(task);
    } on CacheException {
      return const Left(CacheFailure("Cannot updateTask!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, Ok>> saveName(String name) async {
    try {
      await localDataSource.saveName(name);
      return Right(Ok());
    } on CacheException {
      return const Left(CacheFailure("Cannot save!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, String>> getName() async {
    try {
      final name = await localDataSource.getName();
      return Right(name);
    } on CacheException {
      return const Left(CacheFailure("no name!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }
}
