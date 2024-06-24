import 'dart:io';
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
                activeColor: Colors.lightGreen[700],
                value: taskCompleted,
                onChanged: (b) {
                  Get.find<Database>()
                      .changeCabId(note.id, taskCompleted ? 0 : 1);
                }),
            Expanded(
                child: Text(
              note.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        );
      default:
        return Padding(
          padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Text(
            note.text,
            maxLines: 6,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: '霞鹜文楷',
                color: Colors.black,
                overflow: TextOverflow.ellipsis),
          ),
        );
    }
  }
}
