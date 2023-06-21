import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/get_name.dart';
import '../../domain/usecases/remove_username.dart';
import '../../domain/usecases/save_name.dart';

abstract class UserController {
  Future<Either<Failure, Ok>> saveUserName(String id);
  Future<Either<Failure, Ok>> removeUsername();
  Future<Either<Failure, String>> getUserName();
}

class UserControllerImpl extends UserController {
  final SaveName saveName;
  final GetName getName;
  final RemoveUsername removename;
  UserControllerImpl({
    required this.saveName,
    required this.getName,
    required this.removename,
  });

  @override
  Future<Either<Failure, String>> getUserName() async {
    return await getName.call(NoParams());
  }

  @override
  Future<Either<Failure, Ok>> saveUserName(String id) async {
    return await saveName.call(id);
  }

  @override
  Future<Either<Failure, Ok>> removeUsername() async {
    return await removename.call(NoParams());
  }
}
