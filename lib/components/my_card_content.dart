import 'dart:io';

import 'package:cabbbage/models/note.dart';
import 'package:flutter/material.dart';

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
      case 2:
        return Row(
          children: [
            Checkbox(value: false, onChanged: (b) {}),
            Text(note.text),
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
