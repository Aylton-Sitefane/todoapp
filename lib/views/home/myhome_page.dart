import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/views/home/components/my_body.dart';
import 'package:todoapp/data/task_entitie.dart';
import 'package:uuid/uuid.dart';

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: todoActionButton,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Gestao de tarefas'),
        centerTitle: true,
      ),
      body: MyBody(),
    );
  }

  void todoActionButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar tarefa'),
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
                  // Adicionar a tarefa
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
                    final newTask = Task(
                      id: const Uuid().v4(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isCompleted: false,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    // Adicao da tarefa usando task bloc
                    context.read<TaskBloc>().add(AddTaskEvent(newTask));
                  }
                  clearTextFields();
                  Navigator.pop(context);
                },
                child: const Text('Adicionar'),
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
