import 'package:dartz/dartz.dart';
import 'package:task/domain/repositories/user_repositiry.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

class RemoveUsername extends UseCase<Ok, NoParams> {
  final UserRepository _repository;

  RemoveUsername(this._repository);

  @override
  Future<Either<Failure, Ok>> call(NoParams params) async {
    return await _repository.removeUsername();
  }
}
