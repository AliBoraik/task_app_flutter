import 'package:task/core/usecases/usecase.dart';

import 'package:task/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../core/errors/exception.dart';
import '../../domain/repositories/user_repositiry.dart';
import '../datasources/localdata/local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Ok>> saveName(String name) async {
    try {
      await localDataSource.saveName(name);
      return Right(Ok());
    } on CacheException {
      return const Left(CacheFailure("Cannot save!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, String>> getName() async {
    try {
      final name = await localDataSource.getName();
      return Right(name);
    } on CacheException {
      return const Left(CacheFailure("no name!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }

  @override
  Future<Either<Failure, Ok>> removeUsername() async {
    try {
      await localDataSource.removeName();
      return Right(Ok());
    } on CacheException {
      return const Left(CacheFailure("no name!"));
    } catch (e) {
      return const Left(UnknownFailure("Unknown exception"));
    }
  }
}
