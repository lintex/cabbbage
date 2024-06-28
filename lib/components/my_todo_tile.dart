import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyTodoTile extends StatelessWidget {
  const MyTodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  final bool taskCompleted;
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
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(16),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.lightGreen[700],
                checkColor: Colors.black,
                focusColor: Colors.black,
                hoverColor: Colors.black,
              ),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough //显示删除线
                        : TextDecoration.none,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
