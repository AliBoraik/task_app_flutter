import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/data/controller/task_controller.dart';
import 'package:task/data/controller/user_controller.dart';
import 'package:task/domain/usecases/add_task.dart';
import 'package:task/domain/usecases/edit_user_name.dart';
import 'package:task/domain/usecases/get_all_tasks.dart';
import 'package:task/domain/usecases/get_name.dart';
import 'package:task/domain/usecases/remove_task.dart';
import 'package:task/domain/usecases/remove_username.dart';
import 'package:task/domain/usecases/save_name.dart';
import 'package:task/domain/usecases/update_task.dart';
import 'package:task/presentation/bloc/task/task_bloc.dart';
import 'package:task/presentation/bloc/user/user_bloc.dart';

import 'core/util/input_converter.dart';
import 'data/datasources/localdata/database_helper.dart';
import 'data/datasources/localdata/local_data_source.dart';
import 'data/repositorys/task_repository_impl.dart';
import 'data/repositorys/user_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'domain/repositories/user_repositiry.dart';
import 'domain/usecases/delete_all_task.dart';

final sl = GetIt.instance;

void init() {
  //******  Features - Number Trivia *******//
  //Bloc
  sl.registerFactory(
    () => TaskBloc(
      taskController: sl(),
    ),
  );
  sl.registerFactory(
    () => UserBloc(
      userController: sl(),
    ),
  );
  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(databaseHelper: sl()),
  );
  // controller
  sl.registerLazySingleton<TaskController>(
    () => TaskControllerImpl(
      addTask: sl(),
      deleteAllTasks: sl(),
      getAllTasks: sl(),
      deleteTask: sl(),
      updateTask: sl(),
      getName: sl(),
      saveName: sl(),
    ),
  );
  sl.registerLazySingleton<UserController>(
    () => UserControllerImpl(
      getName: sl(),
      saveName: sl(),
      removename: sl(),
      editName: sl(),
    ),
  );

  //******  Use cases *******//
  sl.registerLazySingleton(() => GetAllTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => DeleteAllTasks(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => SaveName(sl()));
  sl.registerLazySingleton(() => GetName(sl()));
  sl.registerLazySingleton(() => RemoveUsername(sl()));
  sl.registerLazySingleton(() => EditName(sl()));

  //******  core *******//
  sl.registerLazySingleton(() => InputConverter());
  //******  External *******//
  sl.registerFactory(() => DatabaseHelper());
}
