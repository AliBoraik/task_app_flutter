import 'package:dartz/dartz.dart';
import 'package:task/domain/usecases/edit_user_name.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/get_name.dart';
import '../../domain/usecases/remove_username.dart';
import '../../domain/usecases/save_name.dart';

abstract class UserController {
  Future<Either<Failure, Ok>> saveUserName(String name);
  Future<Either<Failure, Ok>> editUserName(String name);
  Future<Either<Failure, Ok>> removeUsername();
  Future<Either<Failure, String>> getUserName();
}

class UserControllerImpl extends UserController {
  final SaveName saveName;
  final GetName getName;
  final RemoveUsername removename;
  final EditName editName;
  UserControllerImpl({
    required this.saveName,
    required this.getName,
    required this.removename,
    required this.editName,
  });

  @override
  Future<Either<Failure, String>> getUserName() async {
    return await getName.call(NoParams());
  }

  @override
  Future<Either<Failure, Ok>> saveUserName(String name) async {
    return await saveName.call(name);
  }

  @override
  Future<Either<Failure, Ok>> removeUsername() async {
    return await removename.call(NoParams());
  }

  @override
  Future<Either<Failure, Ok>> editUserName(String name) async {
    return await editName.call(name);
  }
}
