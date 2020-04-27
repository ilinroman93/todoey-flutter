import 'package:flutter/material.dart';
import 'package:todoeyflutter/screens/tasks_screen.dart';
import 'package:todoeyflutter/models/task.dart';
import 'package:todoeyflutter/models/task_data_base.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (context) => DatabaseProvider.dbProvider,
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
