import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, Ok>> saveName(String id);
  Future<Either<Failure, Ok>> removeUsername();
  Future<Either<Failure, String>> getName();
}
