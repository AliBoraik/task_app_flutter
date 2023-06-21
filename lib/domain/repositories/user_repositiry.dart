import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, Ok>> saveName(String name);
  Future<Either<Failure, Ok>> editName(String name);
  Future<Either<Failure, Ok>> removeUsername();
  Future<Either<Failure, String>> getName();
}
