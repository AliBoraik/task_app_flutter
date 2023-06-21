import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class DeleteTask extends UseCase<Ok, String> {
  final TaskRepository _repository;

  DeleteTask(this._repository);

  @override
  Future<Either<Failure, Ok>> call(String id) async {
    return await _repository.deleteTask(id);
  }
}
