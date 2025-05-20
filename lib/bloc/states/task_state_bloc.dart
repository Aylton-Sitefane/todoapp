import 'package:todoapp/data/task_entitie.dart';

abstract class TaskState{}

class TaskInitialState extends TaskState{}

class TaskLoadingState extends TaskState{}

class TaskLoadedState extends TaskState{
  final List<Task> tasks;
  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState{
  final String error;
  TaskErrorState(this.error);
}