import 'dart:io';

import 'package:cabbbage/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCardContent extends StatelessWidget {
  final Note note;
  const MyCardContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    switch (note.cabId) {
      case 8:
        return Image.file(
          File(note.text),
          width: 150,
          fit: BoxFit.cover,
        );
      // 0 为未完成待办
      case 0 || 1:
        // todo 这个地方应该改成MyTodoTile
        return Row(
          children: [
            Checkbox(value: note.cabId == 1 ? true : false, onChanged: (b) {}),
            Expanded(
                child: Text(
              note.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        );
      default:
        return Text(
          // Row里面的Text要包在Expanded里面，不然不换行
          note.text,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: '霞鹜文楷',
              //fontWeight: FontWeight.bold,
              color: Colors.black),
        );
    }
  }
}