import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_float_action_button.dart';
import 'package:cabbbage/components/my_todo_tile.dart';
import 'package:cabbbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: const MyAppBar(title: "待办"),
      body: GetBuilder<Database>(
          init: Database(),
          builder: (db) => ListView.builder(
                itemCount: db.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentTodo = db.todos[index];
                  bool taskCompleted = currentTodo.cabId == 1 ? true : false;
                  return GestureDetector(
                    onTap: () =>
                        db.changeCabId(currentTodo.id, taskCompleted ? 0 : 1),
                    onDoubleTap: () =>
                        Get.toNamed('/editNote', arguments: currentTodo),
                    child: MyTodoTile(
                      taskName: currentTodo.text,
                      taskCompleted: taskCompleted,
                      onChanged: (bool) {
                        db.changeCabId(currentTodo.id, taskCompleted ? 0 : 1);
                      },
                      deleteFunction: (v) {
                        db.deleteNote(currentTodo.id);
                        Get.snackbar("success", "${currentTodo.text}删除成功！",
                            duration: const Duration(seconds: 1));
                      },
                    ),
                  );
                },
              )),
      floatingActionButton: MyFloatActionButton(
        onPressed: () {
          Get.bottomSheet(MyBottomSheet(
            title: '添加待办',
            text: '',
            controller: controller,
            onPressed: () {
              Get.find<Database>().addNote(controller.text, cabId: 0);
              controller.clear();
              Get.back();
              Get.snackbar('success', '待办添加成功！',
                  duration: const Duration(seconds: 1));
            },
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
