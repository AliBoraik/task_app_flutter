import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/controller/task_controller.dart';

import '../../../data/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskController taskController;
  late List<TaskModel> tasks = [];
  TaskBloc({
    required this.taskController,
  }) : super(TaskInitial()) {
    on<GetAllTasksEvent>((event, emit) async {
      emit(LoadingState());
      var result = await taskController.getAll();
      result.fold(
        (left) => {emit(EmptyState())},
        (right) {
          tasks = right;
          _sortTask();
          emit(LoadedTasksState(tasks));
        },
      );
    });
    on<AddTaskEvent>((event, emit) async {
      emit(LoadingState());
      var result = await taskController.addTaskModel(event.task);
      result.fold(
        (left) => {emit(ErrorState(message: left.message))},
        (right) {
          tasks.add(right);
          _sortTask();
          emit(LoadedTasksState(tasks));
        },
      );
    });
    on<DeleteAllTasksEvent>((event, emit) async {
      emit(LoadingState());
      var result = await taskController.deleteAll();
      result.fold(
        (left) => {emit(ErrorState(message: left.message))},
        (_) {
          tasks = [];
          emit(EmptyState());
        },
      );
    });
    on<DeleteTaskEvent>((event, emit) async {
      emit(LoadingState());
      var result = await taskController.deleteTaskModel(event.id);
      result.fold(
        (left) => {emit(ErrorState(message: left.message))},
        (_) {
          _removeById(event.id);
          emit(LoadedTasksState(tasks));
        },
      );
    });
    on<UpdateTaskEvent>((event, emit) async {
      emit(LoadingState());
      var oldTask = _updateTask(event.task);
      emit(LoadedTasksState(tasks));
      var result = await taskController.updateTaskModel(event.task);
      result.fold(
        (left) {
          _reUpdateTask(oldTask);
          emit(LoadedTasksState(tasks));
        },
        (right) {},
      );
    });
  }

  TaskModel findTaskById(String id) {
    return tasks.firstWhere((task) => task.id == id);
  }

  void _sortTask() {
    tasks.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  void _removeById(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  TaskModel _updateTask(TaskModel task) {
    final index = tasks.indexWhere((element) => element.id == task.id);
    var oldTask = tasks[index];
    tasks[index] = task;
    return oldTask;
  }

  void _reUpdateTask(TaskModel task) {
    _updateTask(task);
  }
}
