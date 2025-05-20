import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/events/task_event_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/data/task_entitie.dart';
import 'package:todoapp/views/home/components/show_update_task_dialog.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({ super.key, required this.task });

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ListTile(
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
                            context
                                .read<TaskBloc>()
                                .add(DeleteTaskEvent(task));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showUpdateTaskDialog(context, task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}