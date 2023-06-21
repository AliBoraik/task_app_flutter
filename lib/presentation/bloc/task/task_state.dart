part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class LoadingState extends TaskState {}

class LoadedTasksState extends TaskState {
  final List<TaskModel> tasks;
  const LoadedTasksState(this.tasks);
}

class AddedState extends TaskState {
  final TaskModel task;
  const AddedState(this.task);
}

class EmptyState extends TaskState {}

class ErrorState extends TaskState {
  final String message;

  const ErrorState({required this.message});
}
