import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class SaveName extends UseCase<Ok, String> {
  final TaskRepository _repository;

  SaveName(this._repository);

  @override
  Future<Either<Failure, Ok>> call(String params) {
    return _repository.saveName(params);
  }
}
