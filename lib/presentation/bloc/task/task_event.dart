part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  const AddTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);
}

class DeleteAllTasksEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel task;

  const UpdateTaskEvent(this.task);
}
