import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/states/task_state_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/data/task_entitie.dart';
import 'package:uuid/uuid.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
          return SizedBox.expand(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title.toString()),
                  subtitle: Text(task.description.toString()),
                  trailing: SizedBox(
                    height: 20,
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TaskBloc>().add(DeleteTaskEvent(task));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => updateTask(context, task),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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

  void updateTask(BuildContext context, Task task) {
    _titleController.text = task.title.toString();
    _descriptionController.text = task.description.toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atualizar tarefa'),
          content: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Titulo'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Descricao'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearTextFields();
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            Builder(
              builder: (dialogContext) => TextButton(
                onPressed: () {
                  // Atualizar a tarefa
                  if (_titleController.text.isEmpty ||
                      _descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha os campos!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  } else {
                    // Criacao da tarefa
                    final updatedTask = task.copyWith(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      updatedAt: DateTime.now(),
                    );
                    context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
                  }
                  clearTextFields();
                  Navigator.pop(context);
                },
                child: const Text('Actualizar'),
              ),
            ),
          ],
        );
      },
    );
  }

  void clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
  }
}
