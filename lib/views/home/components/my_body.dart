import 'package:flutter/material.dart';
import 'package:todoapp/views/home/components/task_list.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  
  @override
  Widget build(BuildContext context) {
    return TaskList();
  }

 
}
