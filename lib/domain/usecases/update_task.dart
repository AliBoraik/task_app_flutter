import 'package:task/core/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:task/data/models/task.dart';

import '../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class UpdateTask extends UseCase<TaskModel, TaskModel> {
  final TaskRepository _repository;

  UpdateTask(this._repository);

  @override
  Future<Either<Failure, TaskModel>> call(TaskModel params) async {
    return await _repository.updateTask(params);
  }
}
