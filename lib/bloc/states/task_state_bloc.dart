import 'package:equatable/equatable.dart';
import 'package:todoapp/data/task_entitie.dart';

abstract class TaskState extends Equatable{
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitialState extends TaskState{}

class TaskLoadingState extends TaskState{}

class TaskLoadedState extends TaskState{
  final List<Task> tasks;
  TaskLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskErrorState extends TaskState{
  final String error;
  TaskErrorState(this.error);

  @override
  List<Object?> get props => [error];
}