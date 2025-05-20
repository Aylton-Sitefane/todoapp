import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/data/task_entitie.dart';

void showUpdateTaskDialog(BuildContext context, Task task) {
  final TextEditingController _titleController =
      TextEditingController(text: task.title);
  final TextEditingController _descriptionController =
      TextEditingController(text: task.description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Atualizar Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
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
                );
                // Provide the required positional arguments for UpdateTaskEvent
                context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
              }
              Navigator.pop(context);
            },
            child: const Text('Atualizar'),
          ),
        ],
      );
    },
  );
}
