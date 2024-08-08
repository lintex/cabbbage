import 'dart:io';
import 'package:cabbbage/components/my_checkbox.dart';
import 'package:cabbbage/components/my_read_more_text.dart';
import 'package:cabbbage/models/note.dart';
import 'package:flutter/material.dart';

class MyCardContent extends StatelessWidget {
  final Note note;
  const MyCardContent(
      {super.key, required this.note, this.textCollapsed = true});
  final bool textCollapsed;

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
        return MyCheckbox(
            taskCompleted: taskCompleted, noteId: note.id, text: note.text);
      case >= 250:
        return textCollapsed
            ? MyReadMoreText(note.text)
            : Text(
                note.text,
              );
      default:
        return Text(note.text);
    }
  }
}
