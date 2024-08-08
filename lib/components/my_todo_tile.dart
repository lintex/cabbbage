import 'package:cabbbage/components/my_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyTodoTile extends StatelessWidget {
  const MyTodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onChanged,
    this.deleteFunction,
    required this.noteId,
  });

  final String taskName;
  final bool taskCompleted;
  final int noteId;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      //滑动删除按钮包裹
      child: Slidable(
        // startActionPane: ActionPane(motion: const StretchMotion(), children: [
        //   SlidableAction(
        //     onPressed: deleteFunction,
        //     icon: Icons.check_box_outlined,
        //     backgroundColor: Colors.lightGreen,
        //     borderRadius: BorderRadius.circular(16),
        //   )
        // ]),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(16),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16)),
          child: MyCheckbox(
              taskCompleted: taskCompleted, noteId: noteId, text: taskName),
        ),
      ),
    );
  }
}
