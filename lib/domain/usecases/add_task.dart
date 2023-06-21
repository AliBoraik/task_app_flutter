import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/task.dart';
import '../repositories/task_repository.dart';

class AddTask extends UseCase<TaskModel, TaskModel> {
  final TaskRepository _repository;

  AddTask(this._repository);

  @override
  Future<Either<Failure, TaskModel>> call(TaskModel params) async {
    return await _repository.addTask(params);
  }
}
