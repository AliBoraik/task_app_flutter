import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/user_repositiry.dart';

class EditName extends UseCase<Ok, String> {
  final UserRepository _repository;

  EditName(this._repository);

  @override
  Future<Either<Failure, Ok>> call(String params) {
    return _repository.saveName(params);
  }
}
