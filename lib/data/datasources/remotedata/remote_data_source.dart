import '../../models/task.dart';

abstract class RemoteDataSource {
  Future<List<TaskModel>> getAllTodosLocal();
  Future<TaskModel> addTodo(TaskModel task);
}

//TODO RemoteDataSourceImpl ...
