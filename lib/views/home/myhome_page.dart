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

  TimeOfDay? selectedDuration;

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
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Titulo'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Descricao'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 1, minute: 0),
                              builder: (context, child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedTime != null) {
                              // atualiza apenas o dialog
                              setModalState(() {
                                selectedDuration = pickedTime;
                              });
                            }
                          },
                          child: const Text('Definir duração'),
                        ),
                        const SizedBox(width: 12),
                        if (selectedDuration != null)
                          Text(
                            'Duração: ${selectedDuration!.hour.toString().padLeft(2, '0')}h '
                            '${selectedDuration!.minute.toString().padLeft(2, '0')}m',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                      ],
                    ),
                  ],
                );
              },
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
                  if (_titleController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      selectedDuration == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  final duration = Duration(
                    hours: selectedDuration!.hour,
                    minutes: selectedDuration!.minute,
                  );

                  final newTask = Task(
                    id: const Uuid().v4(),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    isCompleted: false,
                    createdAt: DateTime.now(),
                    deadline: duration,
                  );

                  context.read<TaskBloc>().add(AddTaskEvent(newTask));

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
    selectedDuration = null;
  }
}
