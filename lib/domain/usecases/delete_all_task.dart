import 'package:task/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class DeleteAllTasks extends UseCase<Ok, NoParams> {
  final TaskRepository _repository;

  DeleteAllTasks(this._repository);

  @override
  Future<Either<Failure, Ok>> call(NoParams params) async {
    return await _repository.deleteAllTasks();
  }
}
