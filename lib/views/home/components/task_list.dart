import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/states/task_state_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/views/home/components/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        //Estado inicial do estado
        if (state is TaskInitialState) {
          context.read<TaskBloc>().add(LoadTasksEvents());
          return const Center(
            child: CircularProgressIndicator(),
          );
          // Estado de carregamento do estado
        } else if (state is TaskLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          //Extado processado com sucesso
        } else if (state is TaskLoadedState) {
          final tasks = state.tasks;

          return tasks.isEmpty
              ?  const Center(
                  child: Text('Nenhuma tarefa registada', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                )
              :  ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(task: task);
                  },
                );
        } else if (state is TaskErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text('Estado desconhecido'),
          );
        }
      },
    );
  }
}
