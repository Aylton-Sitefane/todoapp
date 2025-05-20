import 'package:bloc/bloc.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/states/task_state_bloc.dart';
import 'package:todoapp/data/task_entitie.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> _tasks = [];

  TaskBloc() : super(TaskInitialState()) {
    on<LoadTasksEvents>((event, emit) {
      emit(TaskLoadingState());
      // Simulate a delay
      emit(TaskLoadedState(List.from(_tasks)));
    });

    on<AddTaskEvent>((event, emit) {
      _tasks.add(event.task);
      emit(TaskLoadedState(List.from(_tasks)));
    });

    on<DeleteTaskEvent>((event, emit) {
      _tasks.remove(event.task);
      emit(TaskLoadedState(List.from(_tasks)));
    });
  }
}
