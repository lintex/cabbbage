import 'package:cabbbage/components/my_todo_tile.dart';
import 'package:cabbbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "TodoPage"),
      body: GetBuilder<Database>(
          init: Database(),
          builder: (db) => ListView.builder(
                itemCount: db.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentTodo = db.todos[index];
                  bool taskCompleted = currentTodo.cabId == 1 ? true : false;
                  return MyTodoTile(
                    taskName: currentTodo.text,
                    taskCompleted: taskCompleted,
                    onChanged: (bool) {
                      db.changeCabId(currentTodo.id, taskCompleted ? 0 : 1);
                    },
                    deleteFunction: (v) {},
                  );
                },
              )),
    );
  }
}
