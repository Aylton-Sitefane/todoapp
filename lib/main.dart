import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/views/home/myhome_page.dart';
import 'package:todoapp/views/home/provider/task_provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
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