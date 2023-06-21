import 'package:task/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../core/usecases/usecase.dart';
import '../../data/models/task.dart';
import '../repositories/task_repository.dart';

class GetAllTasks extends UseCase<List<TaskModel>, NoParams> {
  final TaskRepository _repository;

  GetAllTasks(this._repository);

  @override
  Future<Either<Failure, List<TaskModel>>> call(NoParams params) async {
    return await _repository.getAllTasks();
  }
}
