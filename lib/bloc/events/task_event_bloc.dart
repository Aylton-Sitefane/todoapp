import 'package:todoapp/data/task_entitie.dart';
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvents extends TaskEvent{}
class AddTaskEvent extends TaskEvent{
  final Task task;
  AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent{
  final Task updatedTask;
  const UpdateTaskEvent(this.updatedTask);

  @override
  List<Object?> get props => [updatedTask];
}

class DeleteTaskEvent extends TaskEvent{
  final Task task;
  const DeleteTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

