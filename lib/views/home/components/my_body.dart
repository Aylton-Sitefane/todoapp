import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/data/task_entitie.dart';
import 'package:todoapp/views/home/provider/task_provider.dart';

class MyBody extends StatefulWidget {
  const MyBody({
    super.key,
  });

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
    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      final tasks = taskProvider.tasks;
      return Column(
        children: [
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa cadastrada',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                        title: Text('${tasks[index].title}'),
                        subtitle: Text('${tasks[index].description}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Add this to prevent Row from taking all space
                          children: [
                            TextButton(
                              onPressed: () {
                                taskProvider.removeTask(tasks[index]);
                              },
                              child: Icon(Icons.delete),
                            ),
                            TextButton(
                              onPressed: () {
                                editTask(context, tasks[index]);
                              },
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  void editTask(BuildContext context, Task task) {
    _titleController.text = task.title!;
    _descriptionController.text = task.description!;

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
                  maxLines: 3,
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
                  if (_titleController.text.isEmpty &&
                      _descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha os campos!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  } else {
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(
                      task,
                      Task(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                        createdAt: task.createdAt,
                        updatedAt: DateTime.now(),
                      ),
                    );
                  }
                 
                  clearTextFields();
                  Navigator.pop(context);
                },
                child: const Text('Atualizar'),
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
