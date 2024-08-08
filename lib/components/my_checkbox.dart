import 'package:cabbbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCheckbox extends StatelessWidget {
  const MyCheckbox(
      {super.key,
      required this.taskCompleted,
      required this.noteId,
      required this.text});
  final bool taskCompleted;
  final int noteId;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Colors.lightGreen.shade400,
            // checkColor: Colors.lightGreen.shade800,
            side: MaterialStateBorderSide.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  //修改勾选时边框颜色
                  return BorderSide(
                      width: 2, color: Colors.lightGreen.shade400);
                }
                //修改默认边框颜色
                return const BorderSide(width: 2, color: Colors.grey);
              },
            ),
            value: taskCompleted,
            onChanged: (b) {
              Get.find<Database>().changeCabId(noteId, taskCompleted ? 0 : 1);
            }),
        Expanded(
            child: Text(
          text.replaceAll('\n', ' '), // 多行待办显示成一行
          style: TextStyle(
            decoration: taskCompleted
                ? TextDecoration.lineThrough //显示删除线
                : TextDecoration.none,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
