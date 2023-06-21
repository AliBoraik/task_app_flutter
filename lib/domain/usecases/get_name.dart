import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/user_repositiry.dart';

class GetName extends UseCase<String, NoParams> {
  final UserRepository _repository;

  GetName(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.getName();
  }
}
