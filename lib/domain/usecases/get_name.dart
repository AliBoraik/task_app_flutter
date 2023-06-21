import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class GetName extends UseCase<String, NoParams> {
  final TaskRepository _repository;

  GetName(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.getName();
  }
}
