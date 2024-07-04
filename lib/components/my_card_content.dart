import 'dart:io';
import 'package:cabbbage/components/my_read_more_text.dart';
import 'package:cabbbage/models/note.dart';
import 'package:cabbbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCardContent extends StatelessWidget {
  final Note note;
  const MyCardContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    switch (note.cabId) {
      case 8:
        // 这个地方图片应该缩小
        return SizedBox(
          width: 150,
          height: 150,
          child: Image.file(
            File(note.text),
            fit: BoxFit.cover,
          ),
        );
      // 0 为未完成待办
      case 0 || 1:
        bool taskCompleted = note.cabId == 1 ? true : false;
        return Row(
          children: [
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.lightGreen.shade400,
                // checkColor: Colors.lightGreen.shade800,
                side: MaterialStateBorderSide.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      //修改勾选时边框颜色
                      return BorderSide(
                          width: 2, color: Colors.lightGreen.shade400);
                    }
                    //修改默认时边框颜色
                    return const BorderSide(width: 2, color: Colors.grey);
                  },
                ),
                value: taskCompleted,
                onChanged: (b) {
                  Get.find<Database>()
                      .changeCabId(note.id, taskCompleted ? 0 : 1);
                }),
            Expanded(
                child: Text(
              note.text.replaceAll('\n', ' '), // 多行待办显示成一行
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
      case >= 250:
        return MyReadMoreText(note.text);
      default:
        return Text(note.text);
    }
  }
}
