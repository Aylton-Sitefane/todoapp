import 'package:flutter/material.dart';
import 'package:todoapp/bloc/task_bloc.dart';
import 'package:todoapp/views/home/myhome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
        ),
       //Adicione outros providers caso necessario
      ],
      
      child: MaterialApp(
        title: 'Todo app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyhomePage(),
      ),
    );
  }
}
