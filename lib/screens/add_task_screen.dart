import 'package:flutter/material.dart';
import 'package:todoeyflutter/models/task_data_base.dart';
import 'package:todoeyflutter/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    DatabaseProvider db = DatabaseProvider.dbProvider;
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 35),
              ),
              TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                onChanged: (newValue) {
                  newTaskTitle = newValue;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                color: Colors.lightBlueAccent,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  db.addTask(Task(name: newTaskTitle));
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
